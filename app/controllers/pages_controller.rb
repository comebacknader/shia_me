class PagesController < ApplicationController
  skip_before_filter :authorize, only: [:home, :about, :invite, :test]
  before_filter :invitecode, only: [:test]
  before_filter :signed_in, only: [:home]
  
  def home
    @subscriber = Subscriber.new
    @user = User.find(1)
    @admin = Admin.find(1)
    @users  = User.all
  end
  
  def about 
   @subscriber = Subscriber.new
   @browser = request.env["HTTP_USER_AGENT"]
  end
  
  def signin
  end
  
  def invite     
  end
  
  def test
  end

    private

  def signed_in 
    if current_user.present? 
      redirect_to current_user
    else if current_admin.present? 
      redirect_to profile_admin_path(current_admin)
    else
       nil
    end
   end
  end
  
end
