class PasswordResetsController < ApplicationController
	skip_before_filter :authorize

  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	user.send_password_reset if user
  	redirect_to userreset_path, :notice => "Email Sent With Password Reset Instructions"
  end

  def edit
  	@user = User.find_by_password_reset_token!(params[:id])
  end

  def update
  	@user = User.find_by_password_reset_token!(params[:id])
  if @user.password_reset_sent_at < 2.hours.ago
  	redirect_to new_password_reset_path, :alert => "Password Reset Has Expired"
  elsif @user.update_attributes(params[:user])
  	sign_in_user @user
  	redirect_to @user, :notice => "Password Has Been Reset"
  else 
  	render "edit"
  end
 end
end