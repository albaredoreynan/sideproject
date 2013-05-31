class CaseReportsPdf < Prawn::Document
	def initialize(case_listing, file_entries, start_date, end_date)
		super( :page_layout => :landscape, top_margin: 50)

		@case_listing = case_listing
		@file_entries = file_entries

		@start_date = start_date
		@end_date = end_date
		
		text "LAWYERS' TIMESHEETS", :size => 15, :style => :bold, :align => :center
		move_down(1)
		text "For the period #{@start_date} up to #{@end_date}", :size => 10, :style => :normal, :align => :center

		move_down(5)
		case_entry_reports
		
	end

	def case_entry_reports
		row1 = []

		@file_entries.each do |fe|
		  row1 << ["MATTER :", fe.title]
		  row1 << [" ", fe.case_number]
		  row1 << [" ", fe.file_code]
		  move_down(2)
		  Client.where("id = ?", fe.client_id).each do |cl|
		  	row1 << ["Client :", cl.name ]
		  end
		end

		table(row1, :width => 720, :cell_style => {:size => 9}) do
			self.row_colors = ["FFFFFF", "FFFFFF"]
			self.header = false
		end
	end

	# def case_entry_listings
		
	# 	row1 = []
	# 	row1 << ['Date Attended', 'Work Particulars', 'Time Spent From', 'Time Spent To', 'Client', 'File Reference #']
	# 	@case_entries.each do |case_entries|
	# 		@client = Client.find(:all, :conditions => { :id => case_entries.client_id} )
	# 		@client.each do |x|
 #              @client_name = x.name
 #            end

	# 		row1 << [
	# 			case_entries.entry_date,
	# 			case_entries.work_particulars,
	# 			case_entries.time_spent_from,
	# 			case_entries.time_spent_to,
	# 			@client_name,
	# 			case_entries.file_matter_case
	# 		]		
	# 	end 
	# 		#row1 << [{:content => 'Employee Name', :colspan => 2 }, {:content => 'Client', :colspan => 2 }, {:content => 'Brand', :colspan => 2 }, {:content => 'Branch', :colspan => 2 }, {:content => 'Date Employed', :colspan => 2 } ]


	# 	table(row1, :width => 720, :cell_style => {:size => 9}) do
	# 		self.row_colors = ["FFFFFF", "FFFFFF"]
	# 		self.header = false
	# 	end

	# end
end