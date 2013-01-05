class MmsgsController < ApplicationController
 before_filter :authorize
 before_filter :admin_not_seen_msg

  def index
    @admin = current_admin    
    @mmsgs = Mmsg.where(:receiver_id => @admin.id).order('created_at DESC').page(params[:page]).per(20)     
    @users = User.where(:admin_id => @admin.id)   
  end

  def show
    @admin = current_admin
    @users = User.where(:admin_id => @admin.id)
  	@mmsg = Mmsg.find(params[:id])
  end

  def new
  	@mmsg = Mmsg.new
  end

  def create 
    @mmsg = Mmsg.new(params[:mmsg])

    if @mmsg.save
      redirect_to @mmsg
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
    redirect_to msgs_path
  end   

end
