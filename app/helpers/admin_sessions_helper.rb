module AdminSessionsHelper
  
  def sign_in(admin)
    cookies.permanent[:anything] = admin.remember_token
    self.current_admin = admin
  end
  
  def current_admin=(admin)
    @current_admin = admin
  end
  
  def current_admin 
    @current_admin ||= Admin.find_by_remember_token(cookies[:anything])
  end    
  
  def current_admin?(admin)
    admin == current_admin
  end
  
  def signed_in? 
    !current_admin.nil? 
  end
  
  def sign_out
    self.current_admin = nil
    cookies.delete(:anything)
  end
  
  def redirect_back_or(default)
    redirect_to(session[:something] || default)
    session.delete(:something)
  end
  
  def store_location 
    session[:something] = request.fullpath
  end
  
  
end
