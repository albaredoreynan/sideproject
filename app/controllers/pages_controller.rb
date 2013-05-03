class PagesController < ApplicationController
	def update_songs
		@file_matters = FileMatter.find(params[:case_entry_file_matter_id])
		#@file_matters = FileMatter.find(:all, :conditions => { :file_matter_id => params[:case_entry_file_matter_id] } )
		#@lawyers =  Lawyer.find(@file_matters.lawyer_id).map{|b|[b.first_name, b.id]}
		@my_clients =  Client.find(:all, :conditions => { :id => @file_matters.client_id } ).map{|b| [b.name, b.id]}
		@my_lawyers =  Lawyer.find(:all, :conditions => { :id => @file_matters.lawyer_id } ).map{|b| [b.first_name, b.id]}
	end
end