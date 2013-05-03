class CaseEntriesPdf < Prawn::Document
	def initialize(case_entries, lawyer)
		super( :page_layout => :landscape, top_margin: 50)

		@case_entries = case_entries
		@lawyer = lawyer
		
		text "Daily Time Record Of : #{@lawyer}"
		move_down(10)
		
		case_entry_listings
		
	end

	def case_entry_listings
		
		row1 = []
		row1 << ['Date Attended', 'Work Particulars', 'Time Spent From', 'Time Spent To', 'Client', 'File Reference #']
		@case_entries.each do |case_entries|
			@client = Client.find(:all, :conditions => { :id => case_entries.client_id} )
			@client.each do |x|
              @client_name = x.name
            end

			row1 << [
				case_entries.entry_date,
				case_entries.work_particulars,
				case_entries.time_spent_from,
				case_entries.time_spent_to,
				@client_name,
				case_entries.file_matter_case
			]		
		end 
			#row1 << [{:content => 'Employee Name', :colspan => 2 }, {:content => 'Client', :colspan => 2 }, {:content => 'Brand', :colspan => 2 }, {:content => 'Branch', :colspan => 2 }, {:content => 'Date Employed', :colspan => 2 } ]


		table(row1, :width => 720, :cell_style => {:size => 9}) do
			self.row_colors = ["FFFFFF", "FFFFFF"]
			self.header = false
		end

	end
end