class CaseReportsPdf < Prawn::Document
	include ActionView::Helpers::NumberHelper

	def initialize(case_listings, file_entries, start_date, end_date, file_matter_id, case_number)
		super( :page_layout => :portrait, top_margin: 15 )

		@case_listings = case_listings
		@file_matter_info = file_entries

		@start_date = start_date
		@end_date = end_date
		@file_matter_id = file_matter_id
		@case_number = case_number
		move_down(30)
		text "TIMESHEETS", :size => 15, :style => :bold, :align => :center
		move_down(2)
		text "For the period #{@start_date.to_time.strftime('%B %d, %Y')} up to #{@end_date.to_time.strftime('%B %d, %Y')}", :size => 10, :style => :normal, :align => :center

		move_down(12)
		move_down(5)
		case_entry_reports(@start_date, @end_date, @file_matter_id, @case_number)
		#case_entry_reports2
	end
	#{:content => 'BEGINNING INVENTORY', :colspan => 3}
	def case_entry_reports(start_date, end_date, file_matter_id, case_number)
		# row2 = []
		row1 = []
		@file_matter_info.each do |fmi|
		  row1 << ["MATTER :", {:content => fmi.title, :font_style => :bold, :colspan => 5 } ]
		  row1 << [" ", {:content => fmi.case_number, :font_style => :bold, :colspan => 5 } ]
		  row1 << [" ", {:content => fmi.file_code, :font_style => :bold, :colspan => 5 } ]
		  move_down(2)
		  @client_name = Client.find(fmi.client_id)
		  row1 << ["CLIENT :", {:content => @client_name.name, :font_style => :bold, :colspan => 5 } ]
		  row1 << [{:content => "", :colspan => 6 }] 	
		  row1 << [{:content => "", :colspan => 6 }]
		  row1 << [{:content => "", :colspan => 6 }]
		  row1 << [{:content => "", :colspan => 6 }]
		  row1 << [{:content => "", :colspan => 6 }]
		  row1 << [{:content => "", :colspan => 6 }]

			@assigned_lawyers = AssignedLawyer.find(:all, :conditions => { :file_matter_id => fmi.id } )
			@assigned_lawyers.each do |al|	
				@total_hours = Array.new
				@case_entries = CaseEntry.find(:all, :conditions => { :file_matter_id => file_matter_id, :lawyer_id => al.lawyer_id, :entry_date => start_date..end_date }, :order => "entry_date DESC"  )
				

				if !@case_entries.empty?

					row1 << ["ATTORNEY :", {:content => al.lawyer.full_name+", "+al.lawyer.position, :colspan => 4, :font_style => :bold } ]
					
					row1 << [{:content => "", :colspan => 6 }] 
					row1 << [{:content => "", :colspan => 6 }]
					row1 << [{:content => "", :colspan => 6 }]
					row1 << [{:content => "", :colspan => 6 }]
					row1 << [
							{:content => "DATE", :background_color => "E8E8D0", :align => :center, :text_color => "001B76", :width => 90, :font_style => :bold }, 
							{:content => "WORK DESCRIPTIONS / PARTICULARS", :background_color => "E8E8D0", :align => :center, :text_color => "001B76", :colspan => 4, :font_style => :bold }, 
							{:content => "TIME SPENT", :background_color => "E8E8D0", :align => :center, :text_color => "001B76", :width => 95, :font_style => :bold }
							]
					@hours = Array.new
					@minutes = Array.new
					@case_entries.each do |ce|
						# @start_time = Time.strptime(ce.time_spent_from, '%I:%M %P')
						# @end_time = Time.strptime(ce.time_spent_to, '%I:%M %P')
						# @time_spent = @end_time - @start_time
						# @value = Time.at(@time_spent).utc.strftime('%I.%M')
						# @total_hours << @value.to_f

						@start_time = Time.strptime(ce.time_spent_from, '%I:%M %P')
						@end_time = Time.strptime(ce.time_spent_to, '%I:%M %P')
						@time_spent = @end_time - @start_time
						@hh = Time.at(@time_spent).utc.strftime('%I')
						if @hh == '12'
							@hh = '00'
						else
							@hh = @hh
						end
						@mm = Time.at(@time_spent).utc.strftime('%M')
						@value = @hh+"."+@mm
						
						@x = @value.to_s
						@xx = @x.split(".")
						@hours << @xx[0].to_i
						@minutes << @xx[1].to_i
						@hr_reg = @hours.inject(:+)
						@min_reg = @minutes.inject(:+)
						if @min_reg >= 60
							@hr_reg = (@min_reg / 60) + @hr_reg
							@min_reg = @min_reg % 60
						end

						

						# row1 << [ ce.entry_date, {:content => ce.work_particulars, :colspan => 2 }, @value ]
						# row1 << [ {:content => ce.entry_date, :align => 'center' }, {:content => ce.work_particulars, :align => 'left' }, {:content => @value, :align => 'center' } ]
						row1 << [
							{:content => "#{ce.entry_date}", :background_color => "ffffff", :align => :center, :text_color => "000000" }, 
							{:content => "#{ce.work_particulars}", :background_color => "ffffff", :align => :left, :text_color => "000000", :colspan => 4 }, 
							{:content => "#{@value}", :background_color => "ffffff", :align => :center, :text_color => "000000" }
							]
					end
						
					if @min_reg < 10 
						@new_min = "0"+@min_reg.to_s 
					else
						@new_min = @min_reg.to_s
					end

					if @hr_reg < 10 
						@new_hr = "0"+@hr_reg.to_s 
					else
						@new_hr = @hr_reg.to_s
					end

					@total_hours = @new_hr+"."+@new_min
					#@grand_total_hours = number_with_precision(@total_hours.inject(:+).to_f, :precision => 2, :delimiter => ',')
					row1 << [
							{:content => "TOTAL HOURS SPENT :", :colspan => 5, :align => :right, :font_style => :bold}, 
							{:content => "#{ number_with_precision(@total_hours.to_f, :precision => 2, :delimiter => ',') }", :align => :center, :font_style => :bold}, 

							]
					
					row1 << [{:content => "", :colspan => 6}] 
					row1 << [{:content => "", :colspan => 6}]
					row1 << [{:content => "", :colspan => 6}]
				
				else

				end 
			end
			row1 << [{:content => "", :colspan => 6 }]
			row1 << [{:content => "", :colspan => 6 }]
			row1 << [{:content => "", :colspan => 6 }]
			row1 << [{:content => "", :colspan => 6 }]
			row1 << [{:content => "", :colspan => 6 }]
			row1 << [{:content => "", :colspan => 6 }]
			row1 << [{:content => "", :colspan => 6 }]
			row1 << [{:content => "SUMMARY OF HOURS AND TIME CHARGES", :colspan => 6, :align => :center, :font_style => :bold }]
			row1 << [
					{:content => "LAWYERS", :background_color => "E8E8D0", :align => :left, :text_color => "001B76", :colspan => 2, :font_style => :bold },
					{:content => "HOURS", :background_color => "E8E8D0", :align => :center, :text_color => "001B76", :font_style => :bold }, 
					{:content => "RATE PER HOUR", :background_color => "E8E8D0", :align => :center, :text_color => "001B76", :font_style => :bold },
					{:content => "TOTAL CHARGES", :background_color => "E8E8D0", :align => :right, :text_color => "001B76", :colspan => 2, :font_style => :bold }

					]
			
			@totals_all = Array.new 
			@assigned_lawyers_list = AssignedLawyer.find(:all, :conditions => { :file_matter_id => fmi.id } )
			@assigned_lawyers_list.each do |laws|
			
				@total_hours2 = Array.new
				@hours2 = Array.new
				@minutes2 = Array.new
				@case_entries2 = CaseEntry.find(:all, :conditions => { :file_matter_id => file_matter_id, :lawyer_id => laws.lawyer_id, :entry_date => start_date..end_date }  )
				
				if !@case_entries2.empty?
					@case_entries2.each do |ce| 
						@start_time2 = Time.strptime(ce.time_spent_from, '%I:%M %P')
						@end_time2 = Time.strptime(ce.time_spent_to, '%I:%M %P')
						@time_spent2 = @end_time2 - @start_time2
						@value2 = Time.at(@time_spent2).utc.strftime('%I.%M')
						@total_hours2 << @value2.to_f
						@hh2 = Time.at(@time_spent2).utc.strftime('%I')
						if @hh2 == '12'
							@hh2 = '00'
						else
							@hh2 = @hh2
						end
						@mm2 = Time.at(@time_spent2).utc.strftime('%M')
						@value2 = @hh2+"."+@mm2
						@total_hours2 << @value2.to_f
						@x2 = @value2.to_s
						@xx2 = @x2.split(".")
						@hours2 << @xx2[0].to_i
						@minutes2 << @xx2[1].to_i
						@hr_reg2 = @hours2.inject(:+)
						@min_reg2 = @minutes2.inject(:+)
						
						if @min_reg2 >= 60
							@hr_reg2 = (@min_reg2 / 60) + @hr_reg2
							@min_reg2 = @min_reg2 % 60
						end



					end

					if @min_reg2 < 10 
						@new_min2 = "0"+@min_reg2.to_s 
					else
						@new_min2 = @min_reg2.to_s
					end

					if @hr_reg2 < 10 
						@new_hr2 = "0"+@hr_reg2.to_s 
					else
						@new_hr2 = @hr_reg2.to_s
					end

					if fmi.currency_used == 'Dollar'
					  @rates = laws.lawyer.dollar_rate
					  @units = "USD "
					else
					  @rates = laws.lawyer.rate
					  @units = "PHP "
					end

					@laws_lawyer_full_name = laws.lawyer.full_name
					@total_actual_hours = @total_hours2.inject(:+)
					@tah = @new_hr2+"."+@new_min2
					#@tah = number_with_precision(@total_actual_hours, :precision => 2, :delimiter => ',')
					@laws_lawyer_rate = number_to_currency( @rates, :unit => @units)
					@multiplier_hours =  ( @new_min2.to_f / 60 ).round(2)
					@total_multi = @hr_reg2 + @multiplier_hours
					@total_hours_final = @total_multi.to_f * @rates.to_f
					@thf =  number_to_currency( @total_hours_final, :unit => @units)
					

					row1 << [
						{:content => "#{@laws_lawyer_full_name}", :background_color => "E8E8D0", :align => :left, :text_color => "001B76", :colspan => 2 }, 
						{:content => "#{@tah}", :background_color => "E8E8D0", :align => :center, :text_color => "001B76" },
						{:content => "#{@laws_lawyer_rate}", :background_color => "E8E8D0", :align => :center, :text_color => "001B76" },
						{:content => "#{@thf}", :background_color => "E8E8D0", :align => :right, :text_color => "001B76", :colspan => 2 }
						]
					@totals_all << @total_hours_final.to_f
				else

				end
			end
			@grand_total_payment = number_to_currency( @totals_all.inject(:+).to_f, :unit => @units)
				row1 << [

						{:content => "CHARGES :", :colspan => 5, :align => :right, :font_style => :bold}, 
						{:content => "#{@grand_total_payment}", :align => :right, :font_style => :bold}
						] 
		end

		table(row1, :width => 540, :cell_style => {:size => 10, :border_color => "FFFFFF", :padding => 1 } ) do
			# column(0).style :align => :center
			# column(1).style :align => :center
			# column(2).style :align => :center
			self.row_colors = ["FFFFFF", "FFFFFF"]
			self.header = false
		end
	end
end
