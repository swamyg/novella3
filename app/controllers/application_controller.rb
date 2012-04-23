# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  def menu_items
    @menu_items ||= Genre.all
  end
  
  def login_required
    if session[:user]
      return true
    end
    flash[:notice]='Please login to continue'
    session[:return_to]=request.request_uri
    redirect_to :controller => "accounts", :action => "login"
    return false 
  end

  def current_user
    session[:user].nil? ? :false : session[:user]
  end
 
  def redirect_to_stored
    if return_to = session[:return_to]
      session[:return_to]=nil
      redirect_to_url(return_to)
    else
      redirect_to :controller=>'main', :action=>'index'
    end
  end
  
  def to_perma_link(str)
    str.downcase.gsub(/\s+/, '-').gsub(/[^a-zA-Z0-9_-]+/, '')
  end

  helper_method :menu_items, :current_user
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "You do not have sufficient privileges to perform this action."
    redirect_to root_url, :alert => exception.message
  end
end
