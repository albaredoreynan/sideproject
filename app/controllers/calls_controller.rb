class CallsController < ApplicationController
  autocomplete :client, :name, :full => true
	def index
    if params[:beginning_date].present? && params[:ending_date].present? || params[:file_matter_id]
      @beginning_date = params[:beginning_date]
      @ending_date = params[:ending_date]
      args = {}
      args.merge!(call_date: params[:beginning_date]..params[:ending_date]) unless params[:beginning_date].blank? 
      @calls = Call.where(args).paginate(:page => params[:page], :per_page => 50, :order => "call_date DESC")
    else
      @beginning_date = Date.today.beginning_of_month.strftime('%b %d, %Y')
      @ending_date = Date.today.strftime('%b %d, %Y')
      @calls = Call.paginate(:page => params[:page], :per_page => 50, :order => "call_date DESC")
    end  
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @calls }
      format.csv  { render :csv => @calls, :except => [:id] }
      format.pdf do 
        pdf = CallEntriesPdf.new(@calls, @beginning_date, @ending_date)
        send_data pdf.render, filename: "Calls Summary Report" + Date.today.to_s + ".pdf", disposition: "inline"
      end
    end

  end

  def show
    @call = Call.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @call }
    end
  end

  def new
    @call = Call.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @call }
    end
  end

  def edit
    @call = Call.find(params[:id])
  end

  def create
    @call = Call.new(params[:call])

    respond_to do |format|
      if @call.save
        format.html { redirect_to calls_path, notice: 'Call entry was successfully created.' }
        format.json { render json: calls_path, status: :created, location: @call }
      else
        format.html { render action: "new" }
        format.json { render json: @call.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @call = Call.find(params[:id])

    respond_to do |format|
      if @call.update_attributes(params[:call])
        format.html { redirect_to calls_path, notice: 'Call entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @call.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @call = Call.find(params[:id])
    @call.destroy

    respond_to do |format|
      format.html { redirect_to @call }
      format.json { head :no_content }
    end
  end

  def ac_client
    render json: Client.select("distinct name as value").where("name ILIKE ?", "%#{params[:term]}%")
    # render json: AnnualProcurementPlan.select("distinct version as value").where("version ILIKE ?", "%#{params[:term]}%").where(:agency_id => current_user.agency.id)
  end
end
