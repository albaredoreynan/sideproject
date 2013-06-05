class CaseEntriesController < ApplicationController
  
  autocomplete :file_matter, :file_code, :full => true
  autocomplete :file_matter, :case_number, :full => true

  def index
    if current_user.role == 'Administrator'
      @case_entries = CaseEntry.all
    else
      @case_entries = CaseEntry.find(:all, :conditions => { :user_id => current_user.id } )
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
    @lawyers = Lawyer.all
    @clients = Client.all
  end

  # POST /case_entries
  # POST /case_entries.json
  def create
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
      format.html { redirect_to case_entries_url }
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
end
