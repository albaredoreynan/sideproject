class AdminSideController < ApplicationController

	def index
		@clients = Client.all
		@lawyers = Lawyer.all
		@file_matters = FileMatter.all

		args = {}
	    args.merge!(lawyer_id: params[:lawyer_id]) unless params[:lawyer_id].blank?
	    args.merge!(client_id: params[:client_id]) unless params[:client_id].blank?
	    args.merge!(entry_date: params[:beginning_date]..params[:ending_date]) unless params[:beginning_date].blank?
	    args.merge!(file_matter_case: params[:file_matter_case]) unless params[:file_matter_case].blank?
	    args.merge!(case_title: params[:case_title]) unless params[:case_title].blank?

	    if params[:lawyer_id] || params[:client_id] || params[:beginning_date] || params[:ending_date] || params[:file_matter_case] || params[:case_title]
	    	@case_listing = CaseEntry.where(args)
	    	args2 = {}
	    	args2.merge!(case_number: params[:file_matter_case]) unless params[:file_matter_case].blank?
	    	args2.merge!(title: params[:case_title]) unless params[:case_title].blank?
	    	@file_entries = FileMatter.where(args2)
	    else
	    	@case_listing = CaseEntry.find(:all, :conditions => { :entry_date => Date.today } )
	    end
	    
	    @start_date = params[:beginning_date]
	    @end_date = params[:ending_date]
	    respond_to do |format|
	    	format.html
	      	format.pdf do 
	        	pdf = CaseReportsPdf.new(@case_listing, @file_entries, @start_date, @end_date)
	        	send_data pdf.render, filename: "Case Reports " + Date.today.to_s + ".pdf", disposition: "inline"
	      	end
    	end
	end

	# def show

	# end
end
