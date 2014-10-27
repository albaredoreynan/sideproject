class PrintEntriesPdf < Prawn::Document
	include ActionView::Helpers::NumberHelper
	def initialize(printouts, beginning_date, ending_date)
		super( :page_layout => :portrait, top_margin: 40)

		@printouts = printouts
		@beginning_date = beginning_date
		@ending_date = ending_date

		text "Print Entry Reports", :size => 15, :style => :bold, :align => :center
		move_down(2)
		text "For the period #{@beginning_date.to_time.strftime('%B %d, %Y')} up to #{@ending_date.to_time.strftime('%B %d, %Y')}", :size => 10, :style => :normal, :align => :center

		move_down(12)
		
		call_entry_listings
		
	end

	def call_entry_listings
		row1 = []
		row1 << [
				{:content => 'Entry Date', :background_color => "E8E8D0", :align => :center, :text_color => "001B76", :font_style => :bold }, 
				{:content => 'File Reference No:', :background_color => "E8E8D0", :align => :center, :text_color => "001B76", :font_style => :bold },
				{:content => 'Copies', :background_color => "E8E8D0", :align => :center, :text_color => "001B76", :font_style => :bold },
				{:content => 'Pages', :background_color => "E8E8D0", :align => :center, :text_color => "001B76", :font_style => :bold },
				{:content => 'Amount', :background_color => "E8E8D0", :align => :center, :text_color => "001B76", :font_style => :bold }
				]
		@total_amount = Array.new
		@printouts.each do |printouts|
			@file_ref = FileMatter.select(:file_code).where(id: printouts.file_matter_id)
			total_pages = printouts.num_copy * printouts.num_page
			amount = printouts.times_amount.to_f * total_pages
			@total_amount << amount.to_f
	  	@pages_amount = number_to_currency(amount.to_f, :unit => "Php ")
	  	# 
			row1 << [
				{:content => "#{printouts.entry_date}", :align => :center, :width => 100 },
				{:content => "#{@file_ref.last.file_code}", :align => :center, :width => 120 },
				{:content => "#{printouts.num_copy}", :align => :center, :width => 80 },
				{:content => "#{printouts.num_page}", :align => :center, :width => 80 },
				{:content => "#{@pages_amount}", :align => :right, :width => 100 }
				
			]		
		end
		@grand_amounts = number_to_currency(@total_amount.inject(:+).to_f, :unit => "Php ")
		row1 << [
				{:content => 'Total Amounts', :align => :right, :font_style => :bold, :colspan => 4}, 
				{:content => "#{@grand_amounts}", :align => :right }
				]


		table(row1, :width => 480, :cell_style => {:size => 9}) do
			self.row_colors = ["FFFFFF", "FFFFFF"]
			self.header = false
		end

	end
end