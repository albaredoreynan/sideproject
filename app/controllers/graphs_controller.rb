class GraphsController < ApplicationController
	autocomplete :file_matter, :file_code, :full => true
	
	def index
		if params[:lawyer_id].blank?
			@lawyers = Lawyer.where(:position => "Associates").limit(5)
		else
			@lawyers = Lawyer.where(:id => params[:lawyer_id])
		end	

		if params[:beginning_date].blank?
			@beginning_date = Date.today.beginning_of_month.strftime('%b %d, %Y')
		else
			@beginning_date = Date.parse(params[:beginning_date], '%b %d, %Y')
		end

		if params[:ending_date].blank?
			@ending_date = Date.today.end_of_month.strftime('%b %d, %Y')
		else
			@ending_date = Date.parse(params[:ending_date], '%b %d, %Y')
		end

		# @beginning_date = Date.today.beginning_of_month.strftime('%b %d, %Y')
		# @ending_date = Date.today.end_of_month.strftime('%b %d, %Y')
		# @case_entries = @case_entries = CaseEntry.where(entry_date: @beginning_date..@ending_date)
		@lawyers2 = Lawyer.all.map{|a|[a.full_name, a.id]}
		
	end

	def search_entry_other_graph
		if params[:file_matter_id].blank? 
			@file_matter_id = FileMatter.all.first
		else
			@file_matter_id = FileMatter.where(:file_code => params[:file_matter_id]).first
		end	

		if params[:beginning_date].blank?
			@beginning_date = Date.today.beginning_of_month.strftime('%b %d, %Y')
		else
			@beginning_date = Date.parse(params[:beginning_date], '%b %d, %Y')
		end

		if params[:ending_date].blank?
			@ending_date = Date.today.end_of_month.strftime('%b %d, %Y')
		else
			@ending_date = Date.parse(params[:ending_date], '%b %d, %Y')
		end

		@assigned_lawyers = AssignedLawyer.where(:file_matter_id => @file_matter_id.id)	
		# @beginning_date = Date.today.beginning_of_month.strftime('%b %d, %Y')
		# @ending_date = Date.today.end_of_month.strftime('%b %d, %Y')
		# @case_entries = @case_entries = CaseEntry.where(entry_date: @beginning_date..@ending_date)
		@lawyers2 = Lawyer.all.map{|a|[a.full_name, a.id]}
	end

	def ac_file_code
    render json: FileMatter.select("distinct file_code as value").where("file_code ILIKE ?", "%#{params[:term]}%")
    # render json: AnnualProcurementPlan.select("distinct version as value").where("version ILIKE ?", "%#{params[:term]}%").where(:agency_id => current_user.agency.id)
  end
end