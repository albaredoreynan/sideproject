class AdminSideController < ApplicationController
	autocomplete :file_matter, :file_code, :full => true
  	autocomplete :file_matter, :case_number, :full => true

	def index
		# @clients = Client.all
		# @lawyers = Lawyer.all
		# @file_matters = FileMatter.all
		
		args = {}
    	args.merge!(file_matter_id: params[:file_matter_id]) unless params[:file_matter_id].blank?
    	args.merge!(case_number: params[:case_number]) unless params[:case_number].blank?
    	args.merge!(entry_date: params[:beginning_date]..params[:ending_date]) unless params[:beginning_date].blank?
    	@case_listings = CaseEntry.where(args).count

	    # if !params[:file_matter_id].blank? || !params[:case_number].blank? || !params[:beginning_date].blank? || !params[:ending_date].blank? 
	    # 	args2 = {}
	    # 	year = params[:file_matter_id].to_s.split("-")[0]
	    # 	code = params[:file_matter_id].to_s.split("-")[1]
	    # 	args2.merge!(year: year.to_int) unless year.blank?
	    # 	args2.merge!(code: code.to_int) unless code.blank?
	    # 	args2.merge!(case_number: params[:case_number]) unless params[:case_number].blank?
	    # 	args2.merge!(entry_date: params[:beginning_date]..params[:ending_date]) unless params[:beginning_date].blank?
	    	
	    # 	args = {}
	    # 	args.merge!(file_matter_id: params[:file_matter_id]) unless params[:file_matter_id].blank?
	    # 	args.merge!(case_number: params[:case_number]) unless params[:case_number].blank?
	    # 	args.merge!(entry_date: params[:beginning_date]..params[:ending_date]) unless params[:beginning_date].blank?
	    # 	@case_listings = CaseEntry.where(args)

	    # 	puts ">>>>"
	    # 	puts @case_listings
	    # 	puts ">>>>"

	    # else
	    # 	@case_listings = CaseEntry.find(:all, :conditions => { :entry_date => Date.today })
	    # end

	    respond_to do |format|
	    	format.html
	      	format.pdf do 
	        	pdf = CaseReportsPdf.new(@case_listing, @file_entries, @start_date, @end_date)
	        	send_data pdf.render, filename: "Case Reports " + Date.today.to_s + ".pdf", disposition: "inline"
	      	end
    	end
	end

	def autocomplete_file_matter_file_code
	    render json: FileMatter.select("distinct file_code as value").where("file_code ILIKE ?", "%#{params[:term]}%")
	    # render json: AnnualProcurementPlan.select("distinct version as value").where("version ILIKE ?", "%#{params[:term]}%").where(:agency_id => current_user.agency.id)
	end

	def autocomplete_file_matter_case_number
		render json: FileMatter.select("distinct case_number as value").where("case_number ILIKE ?", "%#{params[:term]}%")
	    # render json: AnnualProcurementPlan.select("distinct version as value").where("version ILIKE ?", "%#{params[:term]}%").where(:agency_id => current_user.agency.id)
	end
end
