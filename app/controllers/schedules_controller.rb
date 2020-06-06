class SchedulesController < ApplicationController
	helper_method :sort_column, :sort_direction
  def index
    # if params[:schedule].present?
    #   @schedules = Schedule.where("name ILIKE ?", "#{params[:schedule]}").paginate(:page => params[:page], :per_page => 50).order(sort_column + " " + sort_direction)
    # else  
    #   @schedules = Schedule.paginate(:page => params[:page], :per_page => 50).order(sort_column + " " + sort_direction)
    # end
    if current_user.lawyer_id.present?
	  	@schedules = Schedule.where(lawyer_id: current_user.lawyer_id)
	    respond_to do |format|
	      format.html # index.html.erb
	    end
	  else  
	   	@schedules = Schedule.order("schedule_time ASC")
	    respond_to do |format|
	      format.html # index.html.erb
	    end
	  end
  end

  def weekly_view
    if current_user.lawyer_id.present?
	  	@schedules = Schedule.where(lawyer_id: current_user.lawyer_id)
	    respond_to do |format|
	      format.html # index.html.erb
	    end
	  else  
	   	@schedules = Schedule.order("schedule_time ASC")
	    respond_to do |format|
	      format.html # index.html.erb
	    end
	  end
  end

  def daily_view
    if current_user.lawyer_id.present?
    	if params[:date].present?
        if params[:file_matter_id]
          @schedules = Schedule.where(lawyer_id: current_user.lawyer_id).where(start_time: params[:date]).where(file_matter_id: params[:file_matter_id])
          respond_to do |format|
            format.html # index.html.erb
          end
        else  
  		  	@schedules = Schedule.where(lawyer_id: current_user.lawyer_id).where(start_time: params[:date])
  		    respond_to do |format|
  		      format.html # index.html.erb
  		    end
        end
		  end
	  else  
	   	@schedules = Schedule.where(start_time: params[:date]).order("schedule_time ASC")
	    respond_to do |format|
	      format.html # index.html.erb
	    end
	  end
  end

  def show
    @schedule = Schedule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @schedule }
    end
  end

  def new
    @schedule = Schedule.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @schedule }
    end
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def create
    @schedule = Schedule.new(params[:schedule])

    respond_to do |format|
      if @schedule.save
      	if params[:ce]
      		format.html { redirect_to new_case_entry_path, notice: 'Schedule was successfully created.' }
        	# format.json { render json: @schedule, status: :created, location: @schedule }
      	else
        	format.html { redirect_to schedules_path, notice: 'Schedule was successfully created.' }
        	format.json { render json: @schedule, status: :created, location: @schedule }
      	end
      else
        format.html { render action: "new" }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @schedule = Schedule.find(params[:id])

    respond_to do |format|
      if @schedule.update_attributes(params[:schedule])
        format.html { redirect_to schedules_path, notice: 'Schedule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy

    respond_to do |format|
      format.html { redirect_to @schedule }
      format.json { head :no_content }
    end
  end

  def list_schedules
    # @lists = Schedule.find(params[:schedule_id])
  end
  
  def notified
    
    @schedule = Schedule.find(params[:id])
    @schedule.update_attributes(:notified => true)
    respond_to do |format|
      format.html { redirect_to request.referrer, alert: 'You have beend notified.' }
      format.json { head :no_content }
    end
  end

  private
  
  def sort_column
    Schedule.column_names.include?(params[:sort]) ? params[:sort] : "schedule_title"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
