class FileMattersController < ApplicationController
  helper_method :sort_column, :sort_direction
  def index
    if current_user.role == 'Administrator' || current_user.role == 'Billing Clerk'
      if params[:file_code].present? || params[:title].present? || params[:client_code].present?
        args = {}
        args.merge!(file_code: params[:file_code]) unless params[:file_code].blank?
        args.merge!(title: params[:title]) unless params[:title].blank?
        args.merge!(cl_code_txt: params[:client_code]) unless params[:client_code].blank?
        #@case_entries = CaseEntry.where(args).order("entry_date DESC")
        @file_matters = FileMatter.where(args).paginate(:page => params[:page], :per_page => 20).order(sort_column + " " + sort_direction)
      else
        #@case_entries = CaseEntry.find(:all, :conditions => { :lawyer_id => current_user.lawyer_id }, :order => "entry_date DESC" )
        @file_matters = FileMatter.paginate(:page => params[:page], :per_page => 20).order(sort_column + " " + sort_direction)
      end
    else
      args = {}
      @filerefid = AssignedLawyer.where(lawyer_id: current_user.lawyer_id).pluck(:file_matter_id)
      
      args.merge!(id: @filerefid) unless @filerefid.blank?
      if params[:file_code].present? || params[:title].present? || params[:client_code].present?
        
        args.merge!(file_code: params[:file_code]) unless params[:file_code].blank?
        args.merge!(title: params[:title]) unless params[:title].blank?
        args.merge!(:cl_code_txt => params[:client_code]) unless params[:client_code].blank?
        #@case_entries = CaseEntry.where(args).order("entry_date DESC")
        @filerefid = AssignedLawyer.where(lawyer_id: current_user.lawyer_id).pluck(:file_matter_id)
        args.merge!(id: @filerefid) unless @filerefid.blank?
        @file_matters = FileMatter.where(args).paginate(:page => params[:page], :per_page => 20).order(sort_column + " " + sort_direction)
      else
        #@case_entries = CaseEntry.find(:all, :conditions => { :lawyer_id => current_user.lawyer_id }, :order => "entry_date DESC" )
        @file_matters = FileMatter.where(args).paginate(:page => params[:page], :per_page => 20).order(sort_column + " " + sort_direction)
      end
    end  
    @all_fm = FileMatter.order("id ASC")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @file_matters }
      format.csv  { render :csv => @file_matters, :except => [:id] }
      format.xls do 
        headers['Content-Disposition'] = "attachment; filename=\"BackupFileMatters_#{Date.today}.xls\""
      end
      # format.pdf do 
      #   headers['Content-Disposition'] = "attachment; filename=\"#{params[:controller]}\""
      #   render :layout => false
      # end
    end
  end

  def show
    @file_matter = FileMatter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @file_matter }
    end
  end

  def new
    @file_matter = FileMatter.new
    @clients = Client.find(:all, :order => "name ASC")
    @practice_tables = PracticeTable.find(:all, :order => "practice_name ASC")
    @lawyers = Lawyer.find(:all, :order => "first_name ASC")
    @file_matter.assigned_lawyers.build
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @file_matter }
    end
  end

  def edit
    @file_matter = FileMatter.find(params[:id])
    @practice_tables = PracticeTable.find(:all, :order => "practice_name ASC")
    @clients = Client.find(:all, :order => "name ASC")
    @lawyers = Lawyer.find(:all)
    # 5.times {
    #   @file_matter.assigned_lawyers.build
    # }
    
  end

  def create
    @file_matter = FileMatter.new(params[:file_matter])

    respond_to do |format|
      if @file_matter.save
        format.html { redirect_to @file_matter, notice: 'File entry was successfully created.' }
        format.json { render json: @file_matter, status: :created, location: @file_matter }
      else
        format.html { render action: "new" }
        format.json { render json: @file_matter.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @file_matter = FileMatter.find(params[:id])
    respond_to do |format|
      if @file_matter.update_attributes(params[:file_matter])
        @case_entries = CaseEntry.where(file_matter_id: params[:file_matter][:file_code])
        # @case_entries.practice_code = params[:file_matter][:practice_code]
        # @case_entries.client_code = params[:file_matter][:cl_code_txt]
        @client_name = Client.find(params[:file_matter][:client_id])
        @case_entries.update_all(:practice_code => params[:file_matter][:practice_code], :client_code => params[:file_matter][:cl_code_txt], :client_id => params[:file_matter][:client_id], :client_name => @client_name.name)
        format.html { redirect_to @file_matter, notice: 'File entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @file_matter.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @file_matter = FileMatter.find(params[:id])
    @file_matter.destroy

    respond_to do |format|
      format.html { redirect_to @file_matter }
      format.json { head :no_content }
    end
  end

  def autocomplete_file_matter_file_code
    render json: FileMatter.select("distinct file_code as value").where("file_code ILIKE ?", "%#{params[:term]}%")
    # render json: AnnualProcurementPlan.select("distinct version as value").where("version ILIKE ?", "%#{params[:term]}%").where(:agency_id => current_user.agency.id)
  end

  def autocomplete_file_matter_title
    render json: FileMatter.select("distinct title as value").where("title ILIKE ?", "%#{params[:term]}%")
    # render json: AnnualProcurementPlan.select("distinct version as value").where("version ILIKE ?", "%#{params[:term]}%").where(:agency_id => current_user.agency.id)
  end

  private
  
  def sort_column
    Client.column_names.include?(params[:sort]) ? params[:sort] : "file_code"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
