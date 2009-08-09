module ApplicationHelper
  def show_flashes
    retval = ""
    for name in [:notice, :warning, :message, :error]
      if flash[name]
       retval += "<div class=\"flash\ flash_#{name}\"><h3>#{name.to_s.titleize}:</h3><p>#{flash[name]}</p></div>"
      end
    end
    retval
  end

  def render_login_logout
    res = "<div id='login-logout'>"
    link = logged_in? 
    if logged_in?
      res += "<a href='/logout'>Logout</a>"
    else
      res += "<a href='/login'>Login</a>"
    end
    res += "</div>"
  end
end
