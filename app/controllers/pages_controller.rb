# class PagesController < ApplicationController
# 	def update_songs
# 		@file_matters = FileMatter.find(:all, :conditions => { :file_code => params[:case_entry_file_matter_id] } ).first
# 		#@file_matters = FileMatter.find(:all, :conditions => { :file_matter_id => params[:case_entry_file_matter_id] } )
# 		#@lawyers =  Lawyer.find(@file_matters.lawyer_id).map{|b|[b.first_name, b.id]}
# 		#@my_clients =  Client.find(:all, :conditions => { :id => @file_matters.client_id } ).map{|b| [b.name, b.id]}
# 		@my_clients =  Client.find(:all, :conditions => { :id => @file_matters.client_id } ).first
# 		# @my_lawyers =  Lawyer.find(:all, :conditions => { :id => @file_matters.lawyer_id } ).map{|b| [b.full_name, b.id]}

# 		#@file_matters_case_number = FileMatter.select("case_number").find(:all, :conditions => { :id => @file_matters } ).map{ |c| [c.case_number, c.id] }
# 		@file_matters_case_number = FileMatter.select("case_number").find(:all, :conditions => { :id => @file_matters } ).first
# 		@file_matters2 = AssignedLawyer.find(:all, :conditions => { :file_matter_id => @file_matters } )
# 		@lawyers = Array.new
# 		@file_matters2.each do |fm|
# 			if current_user.lawyer_id != fm.lawyer_id
# 				@lawyers << fm.lawyer_id
# 			else
				
# 			end
# 		end
# 		@lawyer_selected = current_user.lawyer_id.to_i
# 		#@my_lawyers =  Lawyer.find(:all, :conditions => ["id IN (?)", @lawyers] ).map{|b| [b.full_name, b.id] }
# 		@my_lawyers =  Lawyer.find(:all, :conditions => ["id IN (?)", @lawyers] )
# 		@my_lawyers_id = current_user.lawyer_id
# 	end

# 	def update_songs2
# 		@file_matters = FileMatter.find(:all, :conditions => { :case_number => params[:case_entry_file_matter_case] } ).first
# 		@my_clients =  Client.find(:all, :conditions => { :id => @file_matters.client_id } ).map{|b| [b.name, b.id]}

# 		@file_matters_case_code = FileMatter.find(:all, :conditions => { :id => @file_matters } ).map{ |c| [c.file_code, c.id] }
# 		@file_matters2 = AssignedLawyer.find(:all, :conditions => { :file_matter_id => @file_matters } )
# 		@lawyers = Array.new
# 		@file_matters2.each do |fm|
# 			@lawyers << fm.lawyer_id
# 		end
# 		@my_lawyers =  Lawyer.find(:all, :conditions => ["id IN (?)", @lawyers] ).map{|b| [b.full_name, b.id]}
# 	end
# end

class PagesController < ApplicationController
  def update_songs
    @file_matters = FileMatter.find(:all, :conditions => { :file_code => params[:case_entry_file_matter_id] } ).first
    #@file_matters = FileMatter.find(:all, :conditions => { :file_matter_id => params[:case_entry_file_matter_id] } )
    #@lawyers =  Lawyer.find(@file_matters.lawyer_id).map{|b|[b.first_name, b.id]}
    #@my_clients =  Client.find(:all, :conditions => { :id => @file_matters.client_id } ).map{|b| [b.name, b.id]}
    @my_clients =  Client.find(:all, :conditions => { :id => @file_matters.client_id } ).first
    # @my_lawyers =  Lawyer.find(:all, :conditions => { :id => @file_matters.lawyer_id } ).map{|b| [b.full_name, b.id]}

    #@file_matters_case_number = FileMatter.select("case_number").find(:all, :conditions => { :id => @file_matters } ).map{ |c| [c.case_number, c.id] }
    @file_matters_case_number = FileMatter.select("case_number").find(:all, :conditions => { :id => @file_matters } ).first
    @file_matters2 = AssignedLawyer.find(:all, :conditions => { :file_matter_id => @file_matters } )
    @lawyers = Array.new
    @file_matters2.each do |fm|
        if current_user.lawyer_id != fm.lawyer_id
            @lawyers << fm.lawyer_id
        else
        end
        # @lawyers << fm.lawyer_id
    end
    @lawyer_selected = current_user.lawyer_id.to_i
    # @my_lawyers =  Lawyer.find(:all, :conditions => ["id IN (?)", @lawyers] ).map{|b| [b.full_name, b.id] }
    @my_lawyers =  Lawyer.find(:all, :conditions => ["id IN (?)", @lawyers] )
    @my_lawyers_id = current_user.lawyer_id
  end

  def update_songs2
    @file_matters = FileMatter.find(:all, :conditions => { :case_number => params[:case_entry_file_matter_case] } ).first
    @my_clients =  Client.find(:all, :conditions => { :id => @file_matters.client_id } ).map{|b| [b.name, b.id]}

    @file_matters_case_code = FileMatter.find(:all, :conditions => { :id => @file_matters } ).map{ |c| [c.file_code, c.id] }
    @file_matters2 = AssignedLawyer.find(:all, :conditions => { :file_matter_id => @file_matters } )
    @lawyers = Array.new
    @file_matters2.each do |fm|
            @lawyers << fm.lawyer_id
    end
    @my_lawyers =  Lawyer.find(:all, :conditions => ["id IN (?)", @lawyers] ).map{|b| [b.full_name, b.id]}
  end


  def parse_client
    @my_clients =  Client.select('id').where("name ILIKE ?", params[:client])
  end

  def update_case_entry
    @file_matters = FileMatter.find(:all, :conditions => { :file_code => params[:file_matter_id] } ).first
    @my_clients =  Client.find(:all, :conditions => { :id => @file_matters.client_id } ).first
    @case_entry_id = params[:case_entry_id]
    @file_matter_id = params[:file_matter_id]
    # @file_matters_case_number = FileMatter.select("case_number").find(:all, :conditions => { :id => @file_matters } ).first
    # @file_matters2 = AssignedLawyer.find(:all, :conditions => { :file_matter_id => @file_matters } )
    # @lawyers = Array.new
    # @file_matters2.each do |fm|
    #         @lawyers << fm.lawyer_id
    # end
    # @lawyer_selected = current_user.lawyer_id.to_i
    # @my_lawyers =  Lawyer.find(:all, :conditions => ["id IN (?)", @lawyers] ).map{|b| [b.full_name, b.id] }
  end

  def printouts_entry
    @file_matters = FileMatter.find(:all, :conditions => { :file_code => params[:printout_file_matter_id] } ).first
    @my_clients =  Client.find(:all, :conditions => { :id => @file_matters.client_id } ).first
    @file_matters_case_number = FileMatter.select("case_number").find(:all, :conditions => { :id => @file_matters } ).first
    @file_matters2 = AssignedLawyer.find(:all, :conditions => { :file_matter_id => @file_matters } )
    @lawyers = Array.new
    @file_matters2.each do |fm|
            @lawyers << fm.lawyer_id
    end
    @lawyer_selected = current_user.lawyer_id.to_i
    @my_lawyers =  Lawyer.find(:all, :conditions => ["id IN (?)", @lawyers] ).map{|b| [b.full_name, b.id] }
  end

  def update_cases
    @client_id = Client.where("name ILIKE ?", "#{params[:client]}").last
    @file_cases =  FileMatter.where(:client_id => @client_id.id.to_s).map{|b| [b.title, b.id]}
    
  end

  def update_search_form
    @file_matters = FileMatter.find(:all, :conditions => { :file_code => params[:case_entry_file_matter_case] } ).first
    @my_clients =  Client.find(:all, :conditions => { :id => @file_matters.client_id } ).first
    @file_matters_case_number = FileMatter.select("case_number").find(:all, :conditions => { :id => @file_matters } ).first
    @file_matters2 = AssignedLawyer.find(:all, :conditions => { :file_matter_id => @file_matters } )
    @lawyers = Array.new
    @file_matters2.each do |fm|
        if current_user.lawyer_id != fm.lawyer_id
            @lawyers << fm.lawyer_id
        else
        end
        # @lawyers << fm.lawyer_id
    end
    @lawyer_selected = current_user.lawyer_id.to_i
    @my_lawyers =  Lawyer.find(:all, :conditions => ["id IN (?)", @lawyers] )
    @my_lawyers_id = current_user.lawyer_id
  end

  def schedule_entry
    @file_matters = FileMatter.find(:all, :conditions => { :file_code => params[:printout_file_matter_id] } ).first
    @my_clients =  Client.find(:all, :conditions => { :id => @file_matters.client_id } ).first
    @file_matters_case_number = FileMatter.select("case_number").find(:all, :conditions => { :id => @file_matters } ).first
    @file_matters2 = AssignedLawyer.find(:all, :conditions => { :file_matter_id => @file_matters } )
    @lawyers = Array.new
    @file_matters2.each do |fm|
            @lawyers << fm.lawyer_id
    end
    @lawyer_selected = current_user.lawyer_id.to_i
    @my_lawyers =  Lawyer.find(:all, :conditions => ["id IN (?)", @lawyers] ).map{|b| [b.full_name, b.id] }
  end

  def add_client_code
    @client = Client.find(:all, :conditions => { :id => params[:file_matter_client_id]} ).first
  end

  def add_practice_code
    @practices = PracticeTable.find(:all, :conditions => { :id => params[:file_matter_practice_table_id]} ).first
  end

  def pick_filematter
    @file_matters = FileMatter.find(:all, :conditions => { :file_code => params[:case_entry_file_matter_case] } ).first
    @my_clients =  Client.find(:all, :conditions => { :id => @file_matters.client_id } ).first
    @file_matters_case_number = FileMatter.select("case_number").find(:all, :conditions => { :id => @file_matters } ).first
    @file_matters2 = AssignedLawyer.find(:all, :conditions => { :file_matter_id => @file_matters } )
    @lawyers = Array.new
    @file_matters2.each do |fm|
        if current_user.lawyer_id != fm.lawyer_id
            @lawyers << fm.lawyer_id
        else
        end
        # @lawyers << fm.lawyer_id
    end
    @lawyer_selected = current_user.lawyer_id.to_i
    @my_lawyers =  Lawyer.find(:all, :conditions => ["id IN (?)", @lawyers] )
    @my_lawyers_id = current_user.lawyer_id
  end

  def select_file_matters
     @datas = CaseEntry.select(:file_matter_id).where(client_code: params[:client_code]).pluck(:file_matter_id)
     @file_references = @datas.uniq
  end
end