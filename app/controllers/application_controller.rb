# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  before_filter :login_required
  
  helper_method :current_user, :logged_in?
  
  def login_required
    if session[:user]
      return true
    else
      session[:return_to] = request.fullpath
      redirect_to login_path
      return false
    end
  end

  def admin_required
    if current_user.admin?
      return true
    else
      flash[:error] = 'Not authorized'
      redirect_to root_path
      return false
    end
  end

  def current_user
    return @current_user if @current_user
    if session[:user]
      @current_user = User.first(:id => session[:user])
    else
      @current_user = User.new(permission_level => 0)
    end
  end

  def logged_in?
    !!session[:user]
  end
  
end
