class PrintoutsController < ApplicationController
  
  autocomplete :file_matter, :file_code, :full => true

	def index
    if params[:beginning_date].present? && params[:ending_date].present? || params[:file_matter_id]
      @beginning_date = params[:beginning_date]
      @ending_date = params[:ending_date]
      args = {}
      args.merge!(entry_date: params[:beginning_date]..params[:ending_date]) unless params[:beginning_date].blank? 
      # @calls = Call.where(args).paginate(:page => params[:page], :per_page => 50, :order => "call_date DESC")
      @printouts = Printout.where(args).paginate(:page => params[:page], :per_page => 50, :order => "entry_date ASC")
    else
      @beginning_date = Date.today.beginning_of_month.strftime('%b %d, %Y')
      @ending_date = Date.today.strftime('%b %d, %Y')
      args = {}
      args.merge!(entry_date: @beginning_date..@ending_date)
      @printouts = Printout.paginate(:page => params[:page], :per_page => 50, :order => "entry_date ASC")
    end  
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @calls }
      format.csv  { render :csv => @calls, :except => [:id] }
      format.pdf do 
        pdf = PrintEntriesPdf.new(@printouts, @beginning_date, @ending_date)
        send_data pdf.render, filename: "Calls Summary Report" + Date.today.to_s + ".pdf", disposition: "inline"
      end
    end
  end

  def show
    @printout = Printout.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @printout }
    end
  end

  def new
    @printout = Printout.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @printout }
    end
  end

  def edit
    @printout = Printout.find(params[:id])
  end

  def create
    @printout = Printout.new(params[:printout])

    respond_to do |format|
      if @printout.save
        format.html { redirect_to printouts_path, notice: 'Printout entry was successfully created.' }
        format.json { render json: printouts_path, status: :created, location: @printout }
      else
        format.html { render action: "new" }
        format.json { render json: @printout.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @printout = Printout.find(params[:id])

    respond_to do |format|
      if @printout.update_attributes(params[:printout])
        format.html { redirect_to printouts_path, notice: 'Printout entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @printout.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @printout = Printout.find(params[:id])
    @printout.destroy

    respond_to do |format|
      format.html { redirect_to printouts_path }
      format.json { head :no_content }
    end
  end

  def ac_file_code
    render json: FileMatter.select("distinct file_code as value").where("file_code ILIKE ?", "%#{params[:term]}%")
    # render json: AnnualProcurementPlan.select("distinct version as value").where("version ILIKE ?", "%#{params[:term]}%").where(:agency_id => current_user.agency.id)
  end
end