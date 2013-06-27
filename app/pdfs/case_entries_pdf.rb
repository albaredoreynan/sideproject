class CaseEntriesPdf < Prawn::Document
	def initialize(case_entries, lawyer)
		super( :page_layout => :landscape, top_margin: 40)

		@case_entries = case_entries
		@lawyer = lawyer
		
		text "Daily Time Record Of : #{@lawyer}"
		move_down(10)
		
		case_entry_listings
		
	end

	def case_entry_listings
		
		row1 = []
		row1 << [
				{:content => 'Date', :background_color => "E8E8D0", :align => :center, :text_color => "001B76", :font_style => :bold, :width => 60 }, 
				{:content => 'Start Time', :background_color => "E8E8D0", :align => :center, :text_color => "001B76", :font_style => :bold, :width => 60 },
				{:content => 'End Time', :background_color => "E8E8D0", :align => :center, :text_color => "001B76", :font_style => :bold, :width => 60 },
				{:content => 'Work Particulars', :background_color => "E8E8D0", :align => :center, :text_color => "001B76", :font_style => :bold }, 
				{:content => 'Client', :background_color => "E8E8D0", :align => :center, :text_color => "001B76", :font_style => :bold, :width => 85 },
				{:content => 'Case Title', :background_color => "E8E8D0", :align => :center, :text_color => "001B76", :font_style => :bold },
				{:content => 'File Reference No', :background_color => "E8E8D0", :align => :center, :text_color => "001B76", :font_style => :bold, :width => 80 }
				]
		
		@case_entries.each do |case_entries|
			@client = Client.find(:all, :conditions => { :id => case_entries.client_id} )
			@client.each do |x|
              @client_name = x.name
            end

			row1 << [
				{:content => "#{case_entries.entry_date}", :align => :center, :width => 70 },
				{:content => "#{case_entries.time_spent_from}", :align => :center },
				{:content => "#{case_entries.time_spent_to}", :align => :center },
				case_entries.work_particulars,
				@client_name,
				case_entries.case_title,
				case_entries.file_matter_case
			]		
		end 
			#row1 << [{:content => 'Employee Name', :colspan => 2 }, {:content => 'Client', :colspan => 2 }, {:content => 'Brand', :colspan => 2 }, {:content => 'Branch', :colspan => 2 }, {:content => 'Date Employed', :colspan => 2 } ]


		table(row1, :width => 690, :cell_style => {:size => 9}) do
			self.row_colors = ["FFFFFF", "FFFFFF"]
			self.header = false
		end

	end
end