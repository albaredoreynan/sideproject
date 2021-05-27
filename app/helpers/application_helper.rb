module ApplicationHelper
	#Flash Message
	def flash_class(level)
  	case level
  		when :notice then "success"
  		when :error then "error"
  		when :alert then "error"
  	end
  end

  def calculate_time(lawyer_id, beg_date, end_date)
  	@case = CaseEntry.where("lawyer_id =? AND entry_date >= ? AND entry_date <= ?", lawyer_id, beg_date, end_date)
  	@total_hours = Array.new
  	@hours = Array.new
		@minutes = Array.new
		
		if !@case.empty?	
			@case.each do |ce|
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
				@value = @hh.to_s+"."+@mm.to_s
				
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
			end
			if @min_reg < 10
				@new_min = "0"+@min_reg2.to_s
			else
				@new_min = @min_reg2.to_s
			end
			
			@total_actual_hours =  @hr_reg.to_s+"."+@new_min.to_s
			return @total_actual_hours.to_f
		
		else
			return 0
		end

  end

  def calculate_time_per_filematter(lawyer_id, beg_date, end_date, file_matter_id)
  	@case = CaseEntry.where("lawyer_id =? AND entry_date >= ? AND entry_date <= ? AND file_matter_id =? ", lawyer_id, beg_date, end_date, file_matter_id)
  	@total_hours = Array.new
  	@hours = Array.new
		@minutes = Array.new
		if !@case.empty?	
			@case.each do |ce|
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
				@value = @hh.to_s+"."+@mm.to_s
				
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
			end
			if @min_reg < 10
				@new_min = "0"+@min_reg2.to_s
			else
				@new_min = @min_reg2.to_s
			end
			
			@total_actual_hours =  @hr_reg.to_s+"."+@new_min.to_s
			return @total_actual_hours.to_f
		else
			return 0
		end
  end

  def calculate_time_per_client(lawyer_id, beg_date, end_date, client_id)
  	@case = CaseEntry.where("lawyer_id =? AND entry_date >= ? AND entry_date <= ? AND client_id =? ", lawyer_id, beg_date, end_date, client_id)
  	@total_hours = Array.new
  	@hours = Array.new
		@minutes = Array.new
		if !@case.empty?	
			@case.each do |ce|
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
				@value = @hh.to_s+"."+@mm.to_s
				
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
			end
			if @min_reg < 10
				@new_min = "0"+@min_reg2.to_s
			else
				@new_min = @min_reg2.to_s
			end
			
			@total_actual_hours =  @hr_reg.to_s+"."+@new_min.to_s
			return @total_actual_hours.to_f
		else
			return 0
		end
  end

  def calculate_client_service(year, month, client_id)
  	if month == 'January'
  		@month_num = '01'
  	elsif month == 'February'
  		@month_num = '02'
  	elsif month == 'March'
  		@month_num = '03'
  	elsif month == 'April'
  		@month_num = '04'
  	elsif month == 'May'
  		@month_num = '05'
  	elsif month == 'June'
  		@month_num = '06'
  	elsif month == 'July'
  		@month_num = '07'
  	elsif month == 'August'
  		@month_num = '08'
  	elsif month == 'September'
  		@month_num = '09'
  	elsif month == 'October'
  		@month_num = '10'
  	elsif month == 'November'
  		@month_num = '11'
  	else month == 'December'
  		@month_num = '12'
  	end

  	@case = CaseEntry.where('EXTRACT(YEAR from entry_date) = ? AND EXTRACT( MONTH from entry_date) = ? AND client_id = ?', year, @month_num, client_id)
  	@total_hours = Array.new
  	@hours = Array.new
		@minutes = Array.new
		if !@case.empty?	
			@case.each do |ce|
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
				@value = @hh.to_s+"."+@mm.to_s
				
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
			end
			if @min_reg < 10
				@new_min = "0"+@min_reg2.to_s
			else
				@new_min = @min_reg2.to_s
			end
			
			@total_actual_hours =  @hr_reg.to_s+"."+@new_min.to_s
			return @total_actual_hours.to_f
		else
			return 0
		end
  end

 #  def sortable(column, title = nil)
	#   title ||= column.titleize
	#   css_class = column == sort_column ? "current #{sort_direction}" : nil
	#   direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
	#   link_to title, {:sort => column, :direction => direction}, {:class => css_class}
	# end

	def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to "#{title} <i class='#{direction == "desc" ? "icon-chevron-down" : "icon-chevron-up"}'></i>".html_safe, {:sort => column, :direction => direction}, {:class => css_class}
	end

	def notification(user_id)
		@today = Date.today
		@notification = Notification.where({user_id: user_id, start_date: @today, notified: nil})
		@notification.count
	end

	def notification_id(user_id)	
		@today = Date.today
		@notification = Notification.where({user_id: user_id, start_date: @today, notified: nil}).pluck(:id)
	end

	def list_notification(user_id)
		@today = Date.today
		@notification = Notification.where({user_id: user_id, start_date: @today, notified: nil})
	end

	def total_number_of_case_entries(lawyer_id, beginning_date, ending_date, file_ref)
		@case = CaseEntry.where("lawyer_id =? AND entry_date >= ? AND entry_date <= ? AND file_matter_id =? ", lawyer_id, beginning_date, ending_date, file_ref)
  	return @case.count
	end

	def count_case_entries(file_ref_no, beg_date, end_date)
		@case_entries = CaseEntry.where(file_matter_id: file_ref_no).where(entry_date: beg_date...end_date)
		counter = @case_entries.count
		return counter
	end

	def extract_year(year, file_matter_id, lawyer_id)
		@case = CaseEntry.where('EXTRACT(YEAR from entry_date) = ? AND file_matter_id = ? AND lawyer_id = ?' , year, file_matter_id, lawyer_id)
		if @case.nil? || @case.empty?
			return 0
		else
			return @case.count
		end
	end

	def count_per_year(year, file_matter_id)
		@case = CaseEntry.where('EXTRACT(YEAR from entry_date) = ? AND file_matter_id = ? ' , year, file_matter_id)
		if @case.nil? || @case.empty?
			return 0
		else
			return @case.count
		end
	end

	def load_year(file_ref_no, beg_date, end_date)
		years = CaseEntry.select(:entry_date).where(entry_date: beg_date...end_date).where(file_matter_id: file_ref_no).pluck(:entry_date).map{ |dt| dt.year }.uniq
		return years
	end
  
  def load_year_per_lawyer(file_ref_no, beg_date, end_date, lawyer_id)
  	years = CaseEntry.select(:entry_date).where(entry_date: beg_date...end_date).where(file_matter_id: file_ref_no).where(lawyer_id: lawyer_id).pluck(:entry_date).map{ |dt| dt.year }.uniq
		return years
  end
end
