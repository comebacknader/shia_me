class UsersessionsController < ApplicationController
  skip_before_filter :authorize
  
  def new
    
  end

  def create
    user = User.find_by_email(params[:usersessions][:email])
    if user && user.authenticate(params[:usersessions][:password])
      sign_in_user user
      redirect_back_or_go user
    else
      flash.now[:error] = "Invalid Email/Password Combination"
      render 'new'
    end
  end
  
  def destroy
    sign_out_user
    redirect_to root_path
  end
  
end
