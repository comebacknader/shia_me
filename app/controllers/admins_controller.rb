class AdminsController < ApplicationController
  before_filter :signed_in_admin, only: [:index, :edit, :update, :pics, :picsupdate]
  before_filter :correct_admin, only: [:edit, :update, :pics, :picsupdate]
  before_filter :invite, only: [:new]
  skip_before_filter :authorize, only: [:show, :new, :create]
  
  def index
    @admins = Admin.all
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
  
  def profile
    @admin = Admin.find(params[:id])
    @users = User.where(:admin_id => current_admin.id)
  end 
  
  def allmen
    @admin = Admin.find(params[:id]) 
    @users = User.where(:admin_id => current_admin.id)
    @men = User.where(:gender => "MALE").order
  end
  
  def allwomen 
    @admin = Admin.find(params[:id])
    @users = User.where(:admin_id => current_admin.id)
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
      flash[:success] = "Picture Changed"
      redirect_to @admin
    else
      render 'pics'
    end
  end
  
  def sendmsg
 	@admin = Admin.find(params[:id])
 	@msg = Msg.new(:admin_id => @admin.id)
    @msgs = Msg.all
    @users = User.where(:admin_id => current_admin.id)	 	
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
