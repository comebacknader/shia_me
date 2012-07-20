class AdminSessionsController < ApplicationController
  
  
  def new
  end
  
  def create
    admin = Admin.find_by_email(params[:admin_sessions][:email])
    if admin && admin.authenticate(params[:admin_sessions][:password])
      # Sign the user in and redirect to user's show page
    else
      flash.now[:error] = "Invalid Email/Password Combination"
      render 'new'
    end
  end
  
  
end
