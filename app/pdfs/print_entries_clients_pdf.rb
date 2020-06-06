class PrintEntriesClientsPdf < Prawn::Document
	include ActionView::Helpers::NumberHelper
	def initialize(printouts, beginning_date, ending_date, file_matters, cname)
		super( :page_layout => :portrait, top_margin: 40)

		@printouts = printouts
		@beginning_date = beginning_date
		@ending_date = ending_date
		@file_matters = file_matters
		# @file_reference_info = FileMatter.find_by_file_code(file_code)
    @client = cname
		text "PRINT/PHOTOCOPY CHARGES", :size => 16, :style => :bold, :align => :center
		move_down(4)
		text "From the period #{@beginning_date.to_time.strftime('%B %d, %Y')} to #{@ending_date.to_time.strftime('%B %d, %Y')}", :size => 11, :style => :normal, :align => :center
    move_down(4)
    text "#{@client.name}", :size => 11, :style => :normal, :align => :center
		move_down(22)
		
		call_entry_listings
		
	end

	def call_entry_listings
		row1 = []
		row2 = []
		@grand_pages = Array.new
		
		@file_matters.each do |fm|
			@file_reference_info = FileMatter.select("title").find(fm)
			row1 << [
							{:content => "MATTER : ", :font_style => :bold},
							{:content => "#{@file_reference_info.title}", :font_style => :bold, :colspan => 2}
							]
			row1 << [{:content => "", :colspan => 3 }] 	
		  row1 << [{:content => "", :colspan => 3 }]
		  row1 << [{:content => "", :colspan => 3 }]
		  row1 << [{:content => "", :colspan => 3 }]
		  row1 << [{:content => "", :colspan => 3 }]
		  row1 << [{:content => "", :colspan => 3 }]

			@file_reference_code = FileMatter.select("file_code").find(fm)
			row1 << [{:content => "FILE REF # :", :font_style => :bold}, {:content => "#{@file_reference_code.file_code}", :font_style => :bold, :colspan => 2} ]
			row1 << [{:content => "", :colspan => 3 }] 	
		  row1 << [{:content => "", :colspan => 3 }]
		  row1 << [{:content => "", :colspan => 3 }]
		  row1 << [{:content => "", :colspan => 3 }]
		  row1 << [{:content => "", :colspan => 3 }]
		  row1 << [{:content => "", :colspan => 3 }]
			row1 << [
					{:content => 'Entry Date', :background_color => "E8E8D0", :align => :center, :text_color => "001B76", :font_style => :bold, :size => 8, :size => 8, :size => 8, :size => 8, :width => 70 },
					{:content => 'Document Name', :background_color => "E8E8D0", :align => :center, :text_color => "001B76", :font_style => :bold, :size => 8, :size => 8, :size => 8, :width => 290 },
					{:content => 'No. of Pages', :background_color => "E8E8D0", :align => :center, :text_color => "001B76", :font_style => :bold, :size => 8, :width => 90 },
					{:content => 'No. of Copies', :background_color => "E8E8D0", :align => :center, :text_color => "001B76", :font_style => :bold, :size => 8, :size => 8, :width => 90 }
					]
			@total_amount = Array.new
			@tot_pages = Array.new
			@printouts.each do |printouts|
				if !printouts.entry_flag?
					if printouts.file_matter_id == fm
						@file_ref = FileMatter.select(:file_code).where(id: printouts.file_matter_id)
						total_pages = printouts.num_copy * printouts.num_page
						@tot_pages << total_pages
						amount = printouts.times_amount.to_f * total_pages
						@total_amount << amount.to_f
				  	@pages_amount = number_to_currency(amount.to_f, :unit => "Php ")
				  	# 
						row1 << [
							{:content => "#{printouts.entry_date}", :align => :center, :width => 70 },
							{:content => "#{printouts.document_name}", :align => :left, :size => 7, :width => 290 },
							{:content => "#{printouts.num_page}", :align => :center, :width => 90 },
							{:content => "#{printouts.num_copy}", :align => :center, :width => 90 }
							
						]
						row1 << [{:content => "", :colspan => 3 }]
					end
				end		
			end
			@grand_pages << @tot_pages.inject(:+)
			# @grand_amounts = number_to_currency(@total_amount.inject(:+).to_f, :unit => "Php ")
			# row1 << [
			# 		{:content => 'Total Amounts', :align => :right, :font_style => :bold, :colspan => 4}, 
			# 		{:content => "#{@grand_amounts}", :align => :right }
			# 		]
			row1 << [{:content => "", :colspan => 3 }] 	
		  row1 << [{:content => "", :colspan => 3 }]
		  row1 << [{:content => "", :colspan => 3 }] 	
		  row1 << [{:content => "", :colspan => 3 }]
		  row1 << [{:content => "", :colspan => 3 }] 	
		  row1 << [{:content => "", :colspan => 3 }]
		  row1 << [{:content => "", :colspan => 3 }] 	
		  row1 << [{:content => "", :colspan => 3 }]
		end


		row1 << [{:content => "", :colspan => 3 }] 	
	  row1 << [{:content => "", :colspan => 3 }]
	  row1 << [{:content => "", :colspan => 3 }] 	
	  row1 << [{:content => "", :colspan => 3 }]
	  row1 << [{:content => "", :colspan => 3 }] 	
	  row1 << [{:content => "", :colspan => 3 }]
	  row1 << [{:content => "", :colspan => 3 }] 	
	  row1 << [{:content => "", :colspan => 3 }]
	  row1 << [{:content => "", :colspan => 3 }] 	
	  row1 << [{:content => "", :colspan => 3 }]
	  row1 << [{:content => "", :colspan => 3 }] 	
	  row1 << [{:content => "", :colspan => 3 }]
	  row1 << [{:content => "", :colspan => 3 }] 	
	  row1 << [{:content => "", :colspan => 3 }]
	  row1 << [{:content => "", :colspan => 3 }] 	
	  row1 << [{:content => "", :colspan => 3 }]
		
	  row2 << [
			{:content => 'FILE REFERENCE NO.', :background_color => "E8E8D0", :align => :center, :text_color => "001B76", :font_style => :bold },
			{:content => 'TOTAL PAGES', :background_color => "E8E8D0", :align => :center, :text_color => "001B76", :font_style => :bold },
			{:content => 'PRICE PER PAGE', :background_color => "E8E8D0", :align => :center, :text_color => "001B76", :font_style => :bold },
			{:content => 'TOTAL', :background_color => "E8E8D0", :align => :center, :text_color => "001B76", :font_style => :bold }
		]

		@grand_tot = Array.new
		@file_matters.each_with_index do |fm, i|
			@file_reference_code = FileMatter.select("file_code").find(fm)
			@price_per_page = 2
			@tot = @grand_pages[i] * @price_per_page
			row2 << [
				{:content => @file_reference_code.file_code, :background_color => "FFFFFF", :align => :center, :text_color => "000000", :size => 8},
				{:content => "#{@grand_pages[i]}", :background_color => "FFFFFF", :align => :center, :text_color => "000000", :size => 8 },
				{:content => "#{number_to_currency(@price_per_page, unit: 'Php ')}", :background_color => "FFFFFF", :align => :center, :text_color => "000000", :size => 8},
				{:content => "#{number_to_currency(@tot, unit: 'Php ')}", :background_color => "FFFFFF", :align => :right, :text_color => "000000", :size => 8}
			]
			@grand_tot << @tot	
		end
	  row2 << [{:content => "", :colspan => 3 }] 	
	  row2 << [{:content => "", :colspan => 3 }]
		@grand_total = number_to_currency(@grand_tot.inject(:+).to_f, :unit => "Php ")
			row2 << [
					{:content => 'Total Amount', :align => :right, :font_style => :bold, :colspan => 3}, 
					{:content => "#{@grand_total}", :align => :right, :font_style => :bold }
					]
		

		table(row1, :width => 540, :cell_style => {:size => 9, :border_color => "FFFFFF", :padding => 1 } ) do
			# column(0).style :align => :center
			# column(1).style :align => :center
			# column(2).style :align => :center
			self.row_colors = ["FFFFFF", "FFFFFF"]
			self.header = false
		end

		table(row2, :width => 540, :cell_style => {:size => 9, :border_color => "FFFFFF", :padding => 1 } ) do
			# column(0).style :align => :center
			# column(1).style :align => :center
			# column(2).style :align => :center
			self.row_colors = ["FFFFFF", "FFFFFF"]
			self.header = false
		end
	end
end