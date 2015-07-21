class NotificationsController < ApplicationController
  helper_method :sort_column, :sort_direction
  def index
    if params[:notification].present?
      @notifications = Notification.where("name ILIKE ?", "#{params[:notification]}").paginate(:page => params[:page], :per_page => 50).order(sort_column + " " + sort_direction)
    else  
      @notifications = Notification.paginate(:page => params[:page], :per_page => 50).order(sort_column + " " + sort_direction)
    end
    @notification_all = Notification.order("name ASC")
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @notification = Notification.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @notification }
    end
  end

  def new
    @notification = Notification.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @notification }
    end
  end

  def edit
    @notification = Notification.find(params[:id])
  end

  def create
    @notification = Notification.new(params[:notification])

    respond_to do |format|
      if @notification.save
        format.html { redirect_to notifications_path, notice: 'Notification was successfully created.' }
        format.json { render json: @notification, status: :created, location: @notification }
      else
        format.html { render action: "new" }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @notification = Notification.find(params[:id])

    respond_to do |format|
      if @notification.update_attributes(params[:notification])
        format.html { redirect_to notifications_path, notice: 'Notification was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy

    respond_to do |format|
      format.html { redirect_to @notification }
      format.json { head :no_content }
    end
  end

  def list_notifications
    # @lists = Notification.find(params[:notification_id])
  end
  
  def notified
    
    @notification = Notification.find(params[:id])
    @notification.update_attributes(:notified => true)
    respond_to do |format|
      format.html { redirect_to request.referrer, alert: 'You have beend notified.' }
      format.json { head :no_content }
    end
  end

  private
  
  def sort_column
    Notification.column_names.include?(params[:sort]) ? params[:sort] : "notification_title"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

end
