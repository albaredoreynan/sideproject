class LawyersController < ApplicationController
  helper_method :sort_column, :sort_direction
  def index
    
    @lawyers = Lawyer.paginate(:page => params[:page], :per_page => 25).order(sort_column + " " + sort_direction)
    @lawyer_all = Lawyer.order("last_name ASC")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lawyers }
      format.csv  { render :csv => @lawyers, :except => [:id] }
      format.xls do 
        headers['Content-Disposition'] = "attachment; filename=\"BackupListLawyers_#{Date.today}.xls\""
      end
      # format.pdf do 
      #   headers['Content-Disposition'] = "attachment; filename=\"#{params[:controller]}\""
      #   render :layout => false
      # end
    end
  end

  def show
    @lawyer = Lawyer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lawyer }
    end
  end

  def new
    @lawyer = Lawyer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lawyer }
    end
  end

  def edit
    @lawyer = Lawyer.find(params[:id])
  end

  def create
    @lawyer = Lawyer.new(params[:lawyer])
    @x = params[:lawyer][:first_name]
    @y = params[:lawyer][:last_name]
    @v = params[:lawyer][:middle_name]
    
    @email = params[:lawyer][:email]
    @name = "#{@x} #{@v} #{@y}"
    @username = "#{@x.slice(0).downcase}#{@v.slice(0).downcase}#{@y.downcase}"
    respond_to do |format|
      if @lawyer.save
        @user = User.new
        @user.email = @email
        @user.name = @name
        @user.username = @username
        @user.password = 'password'
        @user.role = 'User'
        @user.save
        format.html { redirect_to @lawyer, notice: 'Lawyer was successfully created.' }
        format.json { render json: @lawyer, status: :created, location: @lawyer }
      else
        format.html { render action: "new" }
        format.json { render json: @lawyer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @lawyer = Lawyer.find(params[:id])

    respond_to do |format|
      if @lawyer.update_attributes(params[:lawyer])
        format.html { redirect_to @lawyer, notice: 'Lawyer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lawyer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @lawyer = Lawyer.find(params[:id])
    @lawyer.destroy

    respond_to do |format|
      format.html { redirect_to @lawyer }
      format.json { head :no_content }
    end
  end

  def activate_account
    @lawyer = Lawyer.find(params[:id])
    @lawyer.update_attributes(:is_active => 'Yes')
    respond_to do |format|
      format.html { redirect_to request.referrer, alert: 'This lawyer has been activate.' }
      format.json { head :no_content }
    end
  end

  def deactivate_account
    @lawyer = Lawyer.find(params[:id])
    @lawyer.update_attributes(:is_active => 'No')
    respond_to do |format|
      format.html { redirect_to request.referrer, alert: 'This lawyer has been deactivate.' }
      format.json { head :no_content }
    end
  end

  private
  
  def sort_column
    Lawyer.column_names.include?(params[:sort]) ? params[:sort] : "last_name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
