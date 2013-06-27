class Account::UsersController < AccountController
	
	def index
		# #display of brand for a respective user
		# @roles = Role.find(:all, :conditions => { :client_id => @client.id } )
		
		# if params[:role_id]
		# 	@role_level = Role.where('id = ?', params[:role_id])
		# end

		# @user = User.new
		# @client_user_role = @user.client_user_roles.build

		# @brand_account.brand_id.nil? ? @brand_id = '' : @brand_id = @brand_account.brand_id
		
		# @branch_account.branch_id.nil? ? @branch_id = '' : @branch_id = @branch_account.branch_id

		# if @brand_account.brand_id.nil?
		# 	@client_user_roles_list = ClientUserRole.find(:all, :conditions => { :client_id => @client.id} )
		# 	@brands = Brand.find(:all, :conditions => { :client_id => @client.id } )
		# 	@branches = Branch.find(:all, :conditions => ["brand_id = ? AND subscription_status !=? AND subscription_status !=? OR subscription_status IS NULL", @brands.first, "4", "3"])
		# elsif @branch_account.branch_id.nil?
		# 	@client_user_roles_list = ClientUserRole.find(:all, :conditions => { :client_id => @client.id, :brand_id => @brand_id } )
		# 	@brands = Brand.find(:all, :conditions => { :client_id => @client.id, :id => @brand_id } )
		# 	@branches = Branch.find(:all, :conditions => ["brand_id = ? AND subscription_status !=? AND subscription_status !=? OR subscription_status IS NULL", @brands.first, "4", "3"])
		# else
		# 	@client_user_roles_list = ClientUserRole.find(:all, :conditions => { :client_id => @client.id, :branch_id => @branch_id, :brand_id => @brand_id  } )
		# 	@brands = Brand.find(:all, :conditions => { :id => @brand_id } )
		#     @branches = Branch.find(:all, :conditions => ["id =? AND brand_id = ? AND subscription_status !=? AND subscription_status !=? OR subscription_status IS NULL",@branch_id, @brands.first, "4", "3"])
		# end

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
