class AdminSessionsController < ApplicationController
  skip_before_filter :authorize
  
  def new
  end
  
  def create
    admin = Admin.find_by_email(params[:admin_sessions][:email])
    if admin && admin.authenticate(params[:admin_sessions][:password])
      sign_in admin
      redirect_to admin
    else
      flash.now[:error] = "Invalid Email/Password Combination"
      render 'new'
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
  
  
end
