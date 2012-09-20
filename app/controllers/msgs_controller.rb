class MsgsController < ApplicationController
   skip_before_filter :authorize, except: [:index]


  def index
    @msgs = Msg.all
	@admin = current_admin
    @users = User.where(:admin_id => current_admin.id)	
  end

  def show
   	@user = current_user 
	@match = @user.matches.last
	@wmatch = @user.wmatches.last  
    @msg = Msg.find(params[:id])
  end

  def new
   	@user = current_user 
	@match = @user.matches.last
	@wmatch = @user.wmatches.last 
    @lastmsg = @user.msgs.last
    
    @msg = Msg.new(:user_id => @user.id, :admin_id => @user.admin.id)
  end
  
  def create
    @msg = Msg.new(params[:msg])
    
    if @msg.save
      redirect_to messages_path
    else
      render 'new'
    end
  end
  
  def destroy
  end


end
