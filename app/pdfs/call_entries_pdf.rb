class CallEntriesPdf < Prawn::Document
	include ActionView::Helpers::NumberHelper
	def initialize(call_entries, beginning_date, ending_date)
		super( :page_layout => :portrait, top_margin: 40)

		@call_entries = call_entries
		@beginning_date = beginning_date
		@ending_date = ending_date

		text "Call Entry Reports", :size => 15, :style => :bold, :align => :center
		move_down(2)
		text "For the period #{@beginning_date.to_time.strftime('%B %d, %Y')} up to #{@ending_date.to_time.strftime('%B %d, %Y')}", :size => 10, :style => :normal, :align => :center

		move_down(12)
		
		call_entry_listings
		
	end

	def call_entry_listings
		row1 = []
		row1 << [
				{:content => 'Date Received', :background_color => "E8E8D0", :align => :center, :text_color => "001B76", :font_style => :bold }, 
				{:content => 'Minutes Of Call', :background_color => "E8E8D0", :align => :center, :text_color => "001B76", :font_style => :bold },
				{:content => 'Client', :background_color => "E8E8D0", :align => :center, :text_color => "001B76", :font_style => :bold },
				{:content => 'Amount', :background_color => "E8E8D0", :align => :center, :text_color => "001B76", :font_style => :bold }
				]
		@min = Array.new
		@total_amount = Array.new
		@call_entries.each do |call_entries|
			# @client = Client.find(:all, :conditions => { :id => call_entries.client_id} )
			# @client.each do |x|
	  	# @client_name = x.name
	  	# end
	  	@min << call_entries.number_of_minutes
	  	@total_amount << call_entries.call_amounts
	  	@call_amounts = number_to_currency(call_entries.call_amounts, :unit => "Php ")
			row1 << [
				{:content => "#{call_entries.call_date}", :align => :center, :width => 70 },
				{:content => "#{call_entries.number_of_minutes}", :align => :center, :width => 70 },
				call_entries.client,
				{:content => "#{@call_amounts}", :align => :right, :width => 70 }
				
			]		
		end
		@total = number_to_currency(@total_amount.inject(:+), :unit => "Php ") 
		row1 << [
				{:content => 'Total Min', :align => :right, :font_style => :bold}, 
				{:content => "#{@min.inject(:+)}", :align => :center, :width => 70 }, 
				{:content => 'Total Amount', :align => :right, :font_style => :bold}, 
				{:content => "#{@total}", :align => :right, :width => 70 }
				]


		table(row1, :width => 530, :cell_style => {:size => 9}) do
			self.row_colors = ["FFFFFF", "FFFFFF"]
			self.header = false
		end

	end
end