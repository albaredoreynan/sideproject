class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  def render_csv(filename = nil)
    filename += '.csv'

    if request.env['HTTP_USER_AGENT'] =~ /msie/i
      headers['Pragma'] = 'public'
      headers['Content-Type'] = 'text/plain'
      headers['Cache-Control'] = 'no-cache, must-revalidate, post-check=0, pre-check=0'
      headers['Expires'] = "0"
    end
    headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""

    render :layout => false
  end

  private

  def after_sign_in_path_for(user)
    if user.role == 'User'
    	new_case_entry_path
    elsif user.role == 'Encoder-Call'
    	calls_path
    elsif user.role == 'Encoder-Print'
      printouts_path
    elsif user.role == 'Billing Clerk'
      search_entry_path(:pfr => 1)
    else
      graphs_path(:pfr => 1)
    end	
  end

  def after_sign_out_path_for(resource_or_scope)
	scope = Devise::Mapping.find_scope!(resource_or_scope)
	send(:"new_#{scope}_session_path")
  end
  

end
