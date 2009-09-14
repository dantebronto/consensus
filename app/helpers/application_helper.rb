module ApplicationHelper
  def two_decimals(percent)
    "%.2f" % percent
  end
  
  def show_flashes
    retval = ""
    for name in [:notice, :warning, :message, :error]
      if flash[name]
       retval += "<div class=\"flash\ flash_#{name}\"><h3>#{name.to_s.titleize}:</h3><span>#{flash[name]}</span></div>"
      end
    end
    retval
  end
  
  def render_login_logout
    res = ""
    in_or_out = logged_in? ? 'logout' : 'login'

    res += "<a href='/#{in_or_out}'>"
    res += "<span>my session</span><br />"
    res += in_or_out
    res += "</a>"
  end
end
