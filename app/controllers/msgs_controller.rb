class MsgsController < ApplicationController
   skip_before_filter :authorize, except: [:index]
   before_filter :retrieve_newmsg, only: [:new, :show]

  def index
  	@admin = current_admin 
    @msgs = Msg.where(:admin_id => @admin.id, :admin_hide => nil).order('created_at DESC').page(params[:page]).per(3)
    @users = User.where(:admin_id => current_admin.id)	
  end

  def show
   	@user = current_user 
	  @match = @user.matches.last
	  @wmatch = @user.wmatches.last  
    @msg = Msg.find(params[:id])
	  @newmessages = @user.recieved.where(:seen => "false")    
    @question = @user.question    
	   if @msg.seen = "false" 
	     @msg.update_attribute(:seen, "true")
	   end    
  end

  def new
   	@user = current_user 
  	@match = @user.matches.last
	  @wmatch = @user.wmatches.last 
    @lastmsg = @user.msgs.last
    @question = @user.question
	  @newmessages = @user.recieved.where(:seen => "false")    
    
    @msg = Msg.new(:user_id => @user.id, :admin_id => @user.admin.id, :seen => "true")
  end
  
  def create
    @msg = Msg.new(params[:msg])
    
    if @msg.save
    	if current_admin
        @user = @msg.user
          UserMailer.newmessage(@user, current_admin).deliver
    	 redirect_to msgs_path
    	else if current_user
        @user = @msg.admin
          UserMailer.newmessage(@user, current_user).deliver
        redirect_to messages_path
      end
      end
    else
      render 'new'
    end
  end
  
  def destroy
    @msg = Msg.find(params[:id])
    @msg.destroy
    if current_admin
      redirect_to current_admin
    else 
      redirect_to current_user
    end
  end

  def adminhide 
    @msg = Msg.find(params[:id])
    @msg.update_attribute(:admin_hide, "true")
    redirect_to msgs_path
  end   

  def userhide
    @msg = Msg.find(params[:id])
    @msg.update_attribute(:user_hide, "true")
    redirect_to messages_path
  end


end
