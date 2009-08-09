module ApplicationHelper
  def flashes
    ret = ''
    flash.each do |k,v|
      ret << "<div class='flash_#{key}'>"
      ret << v
      ret << "</div>"
    end
  end
  
  def login_required
    if session[:user]
      return true
    else
      session[:return_to] = request.fullpath
      redirect '/login'
      return false
    end
  end

  def admin_required
    if current_user.admin?
      return true
    else
      session[:return_to] = request.fullpath
      session[:flash] = 'not authorized'
      redirect '/'
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

  def render_login_logout
    res = "<div id='login-logout'>"
    link = logged_in? 
    if logged_in?
      res += "<a href='/logout'>logout</a>"
    else
      res += "<a href='/login'>login</a>"
    end
    res += "</div>"
  end
end
