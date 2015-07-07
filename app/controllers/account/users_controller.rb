class Account::UsersController < AccountController
	helper_method :sort_column, :sort_direction
	def index
		@user_list = User.paginate(:page => params[:page], :per_page => 20, :order => "name DESC").order(sort_column + " " + sort_direction)
	end
	
	def new
		@user = User.new
		respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
	end

	def create
		
		@user = User.new(params[:user])

		if current_user.nil?
			if @user.save
				redirect_to account_users_path, :notice => "User '#{@user.username}' successfully created." 
			else
				redirect_to account_users_path, :notice => "Failed to create user."
			end
		else
			
			if @user.save
				redirect_to account_users_path, :notice => "User '#{@user.username}' successfully created." 
			else
				redirect_to account_users_path, :notice => "Failed to create user."
			end
		end
	end

    
	def edit
		@user = User.find(params[:id])
 	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
       redirect_to account_users_path, :notice => "User '#{@user.username}' successfully updated." 
    else
       redirect_to account_users_path, :notice => "Failed to update user."
    end
	end

	def activate_account
		@user = User.find(params[:id])
    @user.update_attributes(:is_active => 'Yes')
    respond_to do |format|
      format.html { redirect_to request.referrer, alert: 'This user has been activate.' }
      format.json { head :no_content }
    end
	end

	def deactivate_account
		@user = User.find(params[:id])
    @user.update_attributes(:is_active => 'No')
    respond_to do |format|
      format.html { redirect_to request.referrer, alert: 'This user has been deactivate.' }
      format.json { head :no_content }
    end
	end

	def destroy
		@user = User.find(params[:id])
    if @user.destroy
 			redirect_to account_users_path
		else
			redirect_to account_users_path
		end
	end
	private
  
  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
