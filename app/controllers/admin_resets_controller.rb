class AdminResetsController < ApplicationController
  skip_before_filter :authorize


  def new
  end

  def create
  	admin = Admin.find_by_email(params[:email])
  	admin.send_admin_reset if admin
  	redirect_to adminreset_path, :notice => "Email Sent With Password Reset Instructions"
  end

  def edit
  	@admin = Admin.find_by_password_reset_token!(params[:id])
  end

  def update
  	@admin = Admin.find_by_password_reset_token!(params[:id])
  if @admin.password_reset_sent_at < 2.hours.ago
  	redirect_to new_admin_reset_path, :alert => "Password Reset Has Expired"
  elseif @admin.update_attributes(params[:admin])
  	sign_in @admin
  	redirect_to @admin, :notice => "Password Has Been Reset"
  else 
  	render "edit"
  end
 end
end


