class CaseEntriesController < ApplicationController
  
  autocomplete :file_matter, :file_code, :full => true

  def index
    @case_entries = CaseEntry.all
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
        format.html { redirect_to @case_entry, notice: 'Case entry was successfully updated.' }
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

  def searching

  end
end
