class AdminsController < ApplicationController
  include AdminsHelper
  before_filter :signed_in_admin, only: [:index, :edit, :update, :pics, :picsupdate, :crop, :cropupdate]
  before_filter :correct_admin, only: [:edit, :update, :pics, :picsupdate, :crop, :cropupdate]
  before_filter :invite, only: [:new]
  skip_before_filter :authorize, only: [:show, :new, :create]
  before_filter :admin_not_seen_msg
  before_filter :matched_users, except: [:show, :new, :create]   
  
  def index
    @admins = Admin.all
    @mmsg = Mmsg.new(:sender_id => current_admin.id)
  end

  def new
    @admin = Admin.new
  end
  
  def create
    @admin = Admin.new(params[:admin])
    
    if @admin.save
      sign_in @admin
      flash[:success] = "Welcome #{@admin.name} "
      redirect_to @admin
    else
      render "new"
    end
  end

  def show
    @user = current_user
    @admin = Admin.find(params[:id])
  end

  def edit
    @admin = Admin.find(params[:id])
  end
  
  def update 
    @admin = Admin.find(params[:id])
    if @admin.update_attributes(params[:admin])
      flash[:success] = "Profile Updated"
      sign_in @admin
      redirect_to profile_admin_path(@admin)
    else
      render 'edit'
    end
  end
  
  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy
    redirect_to profile_admin_path(current_admin)
  end

  def profile
    @admin = @feedable = Admin.find(params[:id])
    @feeds = Feed.order("created_at DESC")
  end 
  
  def allmen
    @admin = Admin.find(params[:id])     
    @men = User.where(:gender => "MALE").order
  end
  
  def allwomen 
    @admin = Admin.find(params[:id])
    @women = User.where(:gender => "FEMALE").order
  end

  def desimen
    @admin = Admin.find(params[:id])     
    @menn = User.where(:gender => "MALE").order
    @men = []
    @menn.each do |men|
      if men.question
        if men.question.ethnicity == "pakistani" || 
          men.question.ethnicity == "indian" ||
          men.question.ethnicity == "desi"
          @men << men
        end
      end
    end
  end

  def persianmen
    @admin = Admin.find(params[:id])     
    @menn = User.where(:gender => "MALE").order
    @men = []
    @menn.each do |men|
      if men.question
        if men.question.ethnicity == "persian" || 
          men.question.ethnicity == "afghan"
          @men << men
        end
      end
    end
  end 

  def arabmen
    @admin = Admin.find(params[:id])     
    @menn = User.where(:gender => "MALE").order
    @men = []
    @menn.each do |men|
      if men.question
        if men.question.ethnicity == "iraqi" || 
          men.question.ethnicity == "arab"
          @men << men
        end
      end
    end
  end   

  def othermen
    @admin = Admin.find(params[:id])     
    @menn = User.where(:gender => "MALE").order
    @men = []
    @menn.each do |men|
      if men.question
        unless men.question.ethnicity == "iraqi" || 
          men.question.ethnicity == "arab" || 
          men.question.ethnicity == "persian" ||
          men.question.ethnicity == "afghan" ||
          men.question.ethnicity == "pakistani" ||
          men.question.ethnicity == "indian" || 
          men.question.ethnicity == "desi" 
          @men << men
        end
      else
        @men << men
      end
    end
  end  


  def desi_women 
    @admin = Admin.find(params[:id])
    @women = User.where(:gender => "FEMALE").order
  end

  def allmatches 
    @users = User.where(:admin_id => current_admin.id)
    @admin = Admin.find(params[:id])
  end
  
  def pics
    @admin = Admin.find(params[:id])
  end
  
  def picsupdate 
    @admin = Admin.find(params[:id])
    if @admin.update_attribute(:avatar, params[:admin][:avatar])
     if params[:admin][:avatar].blank?
      flash[:success] = "Picture Updated"
      sign_in @admin      
	  redirect_to @admin
     else 
     sign_in @admin
      render :action => "crop"
     end
    else
      render 'pics'
    end
  end
  
  def crop
   @admin = Admin.find(params[:id])
  end

  def cropupdate 
    @admin = Admin.find(params[:id])
	 if @admin.update_attributes(params[:admin])
       if @admin.cropping? 
      	@admin.avatar.reprocess!       
        sign_in @admin
        redirect_to  @admin
       else
        sign_in @admin
        render :action => 'crop'
       end 
    else 
       render :action => 'edit'
    end
  end  
  
  def sendmsg
  	@admin = Admin.find(params[:id])
  	@msg = Msg.new(:admin_id => @admin.id, :admin_seen => true)
    @msgs = Msg.all
    @my_users = User.where(:admin_id => @admin.id)
  end
  
  def showmsg 
    @msg = Msg.find(params[:id])
  	@admin = current_admin
    @msg.update_attribute(:admin_seen, "true")
  end

  def deleteusers
    @admin = current_admin
    @all = User.order("name ASC")
  end

  def sentmmsgs
    @admin = current_admin
    @mmsgs = Mmsg.where(:sender_id => @admin.id, :sender_hide => nil).order('created_at DESC').page(params[:page]).per(20)     
  end
    
  
  private 
  
  def signed_in_admin
    unless signed_in? 
      store_location
      redirect_to login_path, notice: "Don't trip yo"
    end
  end
  
  def correct_admin 
    @admin = Admin.find(params[:id])
    redirect_to(root_path) unless current_admin?(@admin)
  end

  
end
