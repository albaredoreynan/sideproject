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

	
end