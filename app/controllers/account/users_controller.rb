class Account::UsersController < AccountController

	def index
		@user_list = User.find(:all)
	end
	 
	def create
		
		# @user = User.new(params[:user])

		# if current_user.nil?
		# 	if @user.save
		# 		redirect_to account_users_path, :notice => "User '#{@user.username}' successfully created." 
		# 	else
		# 		redirect_to account_users_path, :notice => "Failed to create user."
		# 	end
		# else
			
		# 	if @user.save
		# 		redirect_to account_users_path, :notice => "User '#{@user.username}' successfully created." 
		# 	else
		# 		redirect_to account_users_path, :notice => "Failed to create user."
		# 	end
		# end
	end

    
	def edit
		# @user = User.find(params[:id])
		# @brands = Brand.find(:all, :conditions => { :client_id => @client.id } )
		# @branches = Branch.find(:all, :conditions => { :brand_id => @brands.first } )
		# @roles = Role.find(:all, :conditions => { :client_id => @client.id } )
		
		# respond_to do |format|
	 #        format.html { redirect_to account_users_path } 
	 #        format.json { render json: @user}
	 #        format.js 
  # 		end
  	end

	def update
		# @user = User.find(params[:id])
		# if @user.update_attributes(params[:user])
	 #       redirect_to account_users_path, :notice => "User '#{@user.username}' successfully updated." 
	 #    else
	 #       redirect_to account_users_path, :notice => "Failed to update user."
	 #    end
	end

	def destroy
		# @user = User.find(params[:id])
	 #    if @user.destroy
  #  			redirect_to account_users_path
		# else
		# 	redirect_to account_users_path
		# end
	end

end
