class MsgsController < ApplicationController
   skip_before_filter :authorize, except: [:index]


  def index
 	@admin = current_admin 
    @msgs = Msg.where(:admin_id => @admin.id).order('created_at DESC').all
    @users = User.where(:admin_id => current_admin.id)	
  end

  def show
   	@user = current_user 
	@match = @user.matches.last
	@wmatch = @user.wmatches.last  
    @msg = Msg.find(params[:id])
    @question = @user.question    
  end

  def new
   	@user = current_user 
	@match = @user.matches.last
	@wmatch = @user.wmatches.last 
    @lastmsg = @user.msgs.last
    @question = @user.question
    
    @msg = Msg.new(:user_id => @user.id, :admin_id => @user.admin.id)
  end
  
  def create
    @msg = Msg.new(params[:msg])
    
    if @msg.save
    	if current_admin
    	redirect_to current_admin
    	else if current_user
      redirect_to messages_path
      end
      end
    else
      render 'new'
    end
  end
  
  def destroy
  end


end
