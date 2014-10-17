class Account::UsersController < AccountController

	def index
		@user_list = User.paginate(:page => params[:page], :per_page => 20, :order => "name DESC")
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

	end

	def deactivate_account

	end

	# def destroy
	# 	# @user = User.find(params[:id])
	#  #    if @user.destroy
 #  #  			redirect_to account_users_path
	# 	# else
	# 	# 	redirect_to account_users_path
	# 	# end
	# end

end
