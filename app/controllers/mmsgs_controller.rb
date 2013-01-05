class MmsgsController < ApplicationController
 before_filter :authorize
 before_filter :admin_not_seen_msg

  def index
    @admin = current_admin    
    @mmsgs = Mmsg.where(:receiver_id => @admin.id, :receiver_hide => nil).order('created_at DESC').page(params[:page]).per(20)     
    @users = User.where(:admin_id => @admin.id)   
  end

  def show
    @admin = current_admin
    @users = User.where(:admin_id => @admin.id)
  	@mmsg = Mmsg.find(params[:id])
    @mmsg.update_attribute(:receiver_seen, true)
  end

  def new
  	@mmsg = Mmsg.new
  end

  def create 
    @mmsg = Mmsg.new(params[:mmsg])

    if @mmsg.save
      redirect_to mmsgs_path
    else
      render 'new'
    end
  end

  def edit
  	@mmsg = Mmsg.find(params[:id])
  end

  def adminhide 
    @mmsg = Mmsg.find(params[:id])
    @mmsg.update_attribute(:receiver_hide, "true")
    @mmsg.update_attribute(:receiver_seen, "true")
    redirect_to mmsgs_path
  end   

  def sentmmsg 
    @admin = current_admin
    @users = User.where(:admin_id => @admin.id)
    @mmsg = Mmsg.find(params[:id]) 
    @mmsg.update_attribute(:sender_seen, "true")    
  end

  def senthide 
    @mmsg = Mmsg.find(params[:id])
    @mmsg.update_attribute(:sender_hide, "true")
    @mmsg.update_attribute(:sender_seen, "true")
    redirect_to sentmmsgs_admin_path
  end    

end
