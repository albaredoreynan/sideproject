module ApplicationHelper
	#Flash Message
	def flash_class(level)
    	case level
    		when :notice then "success"
    		when :error then "error"
    		when :alert then "error"
    	end
    end

  # method trigger for adding 'active' class on subnav.
  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

end
