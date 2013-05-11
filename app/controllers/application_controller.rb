class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  private

  def after_sign_in_path_for(user)
    if user.role == 'User'
    	new_case_entry_path
    else
    	clients_path
    end	
  end

  def after_sign_out_path_for(resource_or_scope)
	scope = Devise::Mapping.find_scope!(resource_or_scope)
	send(:"new_#{scope}_session_path")
  end
  
end
