module UsersessionsHelper
  
  def sign_in_user(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user 
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end    
  
  def current_user?(user)
    user == current_user
  end
  
  def signed_in_user? 
    !current_user.nil? 
  end
  
  def sign_out_user
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  
  def redirect_back_or_go(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end
  
  def store_this_location 
    session[:return_to] = request.fullpath
  end
  
  
end
