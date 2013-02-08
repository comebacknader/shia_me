class AdminResetsController < ApplicationController
  skip_before_filter :authorize


  def new
  end

  def create
  	admin = Admin.find_by_email(params[:email])
  	admin.send_admin_reset if admin
  	redirect_to adminreset_path, :notice => "Email Sent With Password Reset Instructions"
  end


end


