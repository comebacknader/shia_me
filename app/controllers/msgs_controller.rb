class MsgsController < ApplicationController
  include AdminsHelper
   skip_before_filter :authorize, except: [:index]
   before_filter :retrieve_newmsg, only: [:new, :show]
   before_filter :admin_not_seen_msg, only: [:index, :replymsg] 
   before_filter :matched_users, only: [:index]

  def index
  	@admin = current_admin 
    @mmsgs = Mmsg.where(:receiver_id => @admin.id).order('created_at DESC')    
    @msgs = Msg.where(:admin_id => 
    @admin.id, :admin_hide => nil).order('created_at DESC').
    page(params[:page]).per(20) 
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
    @msg.update_attribute(:admin_seen, "true")
    redirect_to msgs_path
  end   

  def userhide
    @msg = Msg.find(params[:id])
    @msg.update_attribute(:user_hide, "true")
    redirect_to messages_path
  end

  def replymsg
    @lastmsg = Msg.find(params[:id])
    @user = @lastmsg.user
    @admin = current_admin
    @msgs = Msg.all
    @users = User.where(:admin_id => @admin.id)   
    @msg = Msg.new(:user_id => @user.id, :admin_id => current_admin.id, :admin_seen => "true")
  end

end
