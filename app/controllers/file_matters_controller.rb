class FileMattersController < ApplicationController
  
  def index
    if current_user.role == 'Administrator'
      @file_matters = FileMatter.paginate(:page => params[:page], :per_page => 20, :order => "file_code DESC")
    else
      if params[:file_code].present? || params[:title].present? 
        args = {}
        args.merge!(file_code: params[:file_code]) unless params[:file_code].blank?
        args.merge!(title: params[:title]) unless params[:title].blank?
        #@case_entries = CaseEntry.where(args).order("entry_date DESC")
        @file_matters = FileMatter.where(args).paginate(:page => params[:page], :per_page => 20, :order => "file_code DESC")
      else
        #@case_entries = CaseEntry.find(:all, :conditions => { :lawyer_id => current_user.lawyer_id }, :order => "entry_date DESC" )
        @file_matters = FileMatter.paginate(:page => params[:page], :per_page => 20, :order => "file_code DESC")
      end
    end  
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @file_matters }
      format.csv  { render :csv => @file_matters, :except => [:id] }
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
    @lawyers = Lawyer.find(:all, :order => "first_name ASC")
    @file_matter.assigned_lawyers.build
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @file_matter }
    end
  end

  def edit
    @file_matter = FileMatter.find(params[:id])
    @clients = Client.find(:all)
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
end
