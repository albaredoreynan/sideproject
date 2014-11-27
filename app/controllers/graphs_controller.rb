class GraphsController < ApplicationController
	autocomplete :file_matter, :file_code, :full => true
	autocomplete :client, :name, :full => true
	def index
		if params[:lawyer_id].blank?
			@lawyers = Lawyer.where(:position => "Associate")
		else
			if params[:lawyer_id] == ["SENIOR ASSOCIATE"]
				@lawyers = Lawyer.where(:position => 'Senior Associate')
			elsif params[:lawyer_id] == ["ASSOCIATE"]
				@lawyers = Lawyer.where(:position => 'Associate')
			elsif params[:lawyer_id] == ["PARTNER"]
				@lawyers = Lawyer.where(:position => 'Partner')	
			else	
				@lawyers = Lawyer.where(:id => params[:lawyer_id])
			end
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
		@lawyers2 << ['SENIOR ASSOCIATE','SENIOR ASSOCIATE']
		@lawyers2 << ['ASSOCIATE','ASSOCIATE']
		@lawyers2 << ['PARTNER','PARTNER']
		
	end

	def search_entry_other_graph
		if params[:file_matter_id].blank? 
			@file_matter_id = FileMatter.all.first
		else
			@file_matter_id = FileMatter.where(:file_code => params[:file_matter_id]).last
			@assigned_lawyers = AssignedLawyer.where(:file_matter_id => @file_matter_id.id)	
			@lawyers2 = Lawyer.all.map{|a|[a.full_name, a.id]}
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
	end

	def search_entry_other_graph2
		@months = Array.new
		if params[:client].blank? 
			@client_id = Client.all.first
		else
			@client_id = Client.where("name ILIKE ?", "#{params[:client]}").last
			# @file_reference = FileMatter.where(:id => params[:file_matter_id])
			# @assigned_lawyers = AssignedLawyer.where(:file_matter_id => params[:file_matter_id])	
			# @lawyers2 = Lawyer.all.map{|a|[a.full_name, a.id]}
		end
		@months << ['January',1]	
		# if params[:beginning_date].blank?
		# 	@beginning_date = Date.today.beginning_of_month.strftime('%b %d, %Y')
		# else
		# 	@beginning_date = Date.parse(params[:beginning_date], '%b %d, %Y')
		# end

		# if params[:ending_date].blank?
		# 	@ending_date = Date.today.end_of_month.strftime('%b %d, %Y')
		# else
		# 	@ending_date = Date.parse(params[:ending_date], '%b %d, %Y')
		# end
	end

	def ac_client_gr
		render json: Client.select("distinct name as value").where("name ILIKE ?", "%#{params[:term]}%")
	end

	def ac_file_code
    render json: FileMatter.select("distinct file_code as value").where("file_code ILIKE ?", "%#{params[:term]}%")
  end
end