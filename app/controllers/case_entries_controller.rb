class CaseEntriesController < ApplicationController
  
  autocomplete :file_matter, :file_code, :full => true
  autocomplete :file_matter, :case_number, :full => true

  def index
    if current_user.role == 'Administrator'
      @case_entries = CaseEntry.find(:all, :order => "entry_date DESC")
    else
      @case_entries = CaseEntry.find(:all, :conditions => { :lawyer_id => current_user.lawyer_id }, :order => "entry_date DESC" )
    end
    @lawyer = current_user.name
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @case_entries }
      # format.csv  { render :csv => @case_entries, :except => [:id] }
      
      format.pdf do 
        pdf = CaseEntriesPdf.new(@case_entries, @lawyer)
        send_data pdf.render, filename: "Case Entry " + Date.today.to_s + ".pdf", disposition: "inline"
      end
    end
  end

  # GET /case_entries/1
  # GET /case_entries/1.json
  def show
    @case_entry = CaseEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @case_entry }
    end
  end

  # GET /case_entries/new
  # GET /case_entries/new.json
  def new
    @case_entry = CaseEntry.new
    @file_matters = FileMatter.find(:all, :group => "file_code, id")
    @file_matter_case = FileMatter.find(:all, :group => "case_number, id")
    @lawyers = Lawyer.all
    @clients = Client.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @case_entry }
    end
  end

  # GET /case_entries/1/edit
  def edit
    @case_entry = CaseEntry.find(params[:id])
    @file_matters = FileMatter.all
    @lawyers = Lawyer.find(:all, :conditions => { :id => @case_entry.lawyer_id } )
    @clients = Client.all
  end

  # POST /case_entries
  # POST /case_entries.json
  def create

    if params[:case_entry][:create_multiple_lawyer_entries] == "1"
      
      @assigned_lawyers = AssignedLawyer.find(:all, :conditions => { :file_matter_id => params[:filematter_id] } )
        
        @assigned_lawyers.each do |al|
          
          @users = User.find(:all, :conditions => {:lawyer_id => al.lawyer_id }  )
          @users.each do |usr|
            @case_entry = CaseEntry.new(
              :file_matter_id => params[:case_entry][:file_matter_id],
              :entry_date => params[:case_entry][:entry_date],
              :time_spent_from => params[:case_entry][:time_spent_from], 
              :time_spent_to => params[:case_entry][:time_spent_to], 
              :work_particulars => params[:case_entry][:work_particulars], 
              :client_id => params[:case_entry][:client_id], 
              :case_title => params[:case_entry][:case_title], 
              :file_matter_case => params[:case_entry][:file_matter_case], 
              :lawyer_id => al.lawyer_id, 
              :create_multiple_lawyer_entries => params[:case_entry][:create_multiple_lawyer_entries], 
              :user_id => usr.id 
            )
            @case_entry.save  
          end

        end
        respond_to do |format|
          format.html { redirect_to case_entries_path(), notice: 'Case entries was successfully created.' }
          format.json { render json: @case_entry, status: :created, location: @case_entry }
        end

    else
      
      @case_entry = CaseEntry.new(params[:case_entry])
      respond_to do |format|
        if @case_entry.save
          format.html { redirect_to case_entries_path(), notice: 'Case entry was successfully created.' }
          format.json { render json: @case_entry, status: :created, location: @case_entry }
        else
          format.html { render action: "new" }
          format.json { render json: @case_entry.errors, status: :unprocessable_entity }
        end
      end

    end

    

  end

  # PUT /case_entries/1
  # PUT /case_entries/1.json
  def update
    @case_entry = CaseEntry.find(params[:id])

    respond_to do |format|
      if @case_entry.update_attributes(params[:case_entry])
        format.html { redirect_to case_entries_path, notice: 'Case entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @case_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /case_entries/1
  # DELETE /case_entries/1.json
  def destroy
    @case_entry = CaseEntry.find(params[:id])
    @case_entry.destroy

    respond_to do |format|
      format.html { redirect_to case_entries_path, alert: 'Case entry has been deleted.' }
      format.json { head :no_content }
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

  def search_entry
      # args = {}
      # args.merge!(file_matter_id: params[:file_matter_id]) unless params[:file_matter_id].blank?
      # args.merge!(case_number: params[:case_number]) unless params[:case_number].blank?
      # args.merge!(entry_date: params[:beginning_date]..params[:ending_date]) unless params[:beginning_date].blank?
      # @case_listings = CaseEntry.where(args)

      # if !params[:file_matter_id].blank? || !params[:case_number].blank? || !params[:beginning_date].blank? || !params[:ending_date].blank? 
        args2 = {}
        year = params[:file_matter_id].to_s.split("-")[0]
        code = params[:file_matter_id].to_s.split("-")[1]
        #args2.merge!(year: year) unless year.blank?
        args2.merge!(file_code: params[:file_matter_id]) unless params[:file_matter_id].blank?
        args2.merge!(case_number: params[:case_number]) unless params[:case_number].blank?
        #args2.merge!(entry_date: params[:beginning_date]..params[:ending_date]) unless params[:beginning_date].blank?
        
        args = {}
        args.merge!(file_matter_id: params[:file_matter_id]) unless params[:file_matter_id].blank?
        args.merge!(file_matter_case: params[:case_number]) unless params[:case_number].blank?
        args.merge!(entry_date: params[:beginning_date]..params[:ending_date]) unless params[:beginning_date].blank?
        if params[:file_matter_id].blank? && params[:case_number].blank? && params[:beginning_date].blank? && params[:ending_date].blank?
          @case_listings = nil
        else
          @case_listings = CaseEntry.where(args)
        end
        
        @file_matter_info = FileMatter.where(args2)
        # if !params[:file_matter_id].nil? && !params[:case_number].nil?
        #   @file_matter_info = FileMatter.find(:all, :conditions => { :year => year, :file_code => code, :case_number => params[:case_number] } )
        #   @case_listings = CaseEntry.where(args)
        # elsif !params[:case_number].nil? && params[:case_number].nil?
        #   @file_matter_info = FileMatter.find(:all, :conditions => { :year => year, :file_code => code } )
        #   @case_listings = CaseEntry.where(args)
        # elsif params[:case_number].nil? && !params[:case_number].nil?
        #   @file_matter_info = FileMatter.find(:all, :conditions => { :case_number => params[:case_number] } )
        #   @case_listings = CaseEntry.where(args)
        # else
        #   @file_matter_info = nil
        #   @case_listings = nil
        # end

        # if params[:file_matter_id].blank? && params[:case_number].blank?
        #   @case_entries = CaseEntry.find(:all, :conditions => { :lawyer_id => al.lawyer_id, :entry_date => params[:beginning_date] .. params[:ending_date] }  )
        # elsif !params[:file_matter_id].blank? && params[:case_number].blank?
        #   @case_entries = CaseEntry.find(:all, :conditions => { :file_matter_id => params[:file_matter_id], :lawyer_id => al.lawyer_id, :entry_date => params[:beginning_date] .. params[:ending_date] }  )
        # elsif params[:file_matter_id].blank? && !params[:case_number].blank?
        #   @case_entries = CaseEntry.find(:all, :conditions => { :file_matter_case => params[:case_number], :lawyer_id => al.lawyer_id, :entry_date => params[:beginning_date] .. params[:ending_date] }  )
        # else
        #   @case_entries = CaseEntry.find(:all, :conditions => { :file_matter_id => params[:file_matter_id], :file_matter_case => params[:case_number], :lawyer_id => al.lawyer_id, :entry_date => params[:beginning_date] .. params[:ending_date] }  )
        # end      
          
        @start_date = params[:beginning_date]
        @end_date = params[:ending_date]
        @file_matter_id = params[:file_matter_id]
        @case_number = params[:case_number]

      # else
      #   @case_listings = CaseEntry.find(:all, :conditions => { :entry_date => Date.today })
      # end

      respond_to do |format|
          format.html

          format.pdf do 
            pdf = CaseReportsPdf.new(@case_listings, @file_matter_info, @start_date, @end_date, @file_matter_id, @case_number)
            send_data pdf.render, filename: "Case Reports " + Date.today.to_s + ".pdf", disposition: "inline"
          end

          format.csv { send_data @case_entries.to_csv }
          format.xls
          
      end
  end    
end
