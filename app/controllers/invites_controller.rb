class InvitesController < ApplicationController
  skip_before_filter :authorize
  before_filter :admin_not_seen_msg

  def index 
    @invites = Invite.all
    @admin = current_admin
    @users = User.where(:admin_id => current_admin.id)
    @men = User.where(:gender => "MALE").order   
  end

  def new  
    @invite = Invite.new
  end
  
  def create
    @invite = Invite.new(params[:invite])
  
    if @invite.save 
      flash[:success] = "Code Created!"
      redirect_to invites_path
    else
      render 'new'
    end
  end
  
  def destroy
    @invite = Invite.find(params[:id])
    @invite.destroy
    flash[:notice] = "Code Deleted"
    redirect_to invites_path
  end
  
  
end

