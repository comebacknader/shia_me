class AdminsController < ApplicationController
  before_filter :signed_in_admin, only: [:index, :edit, :update, :pics, :picsupdate]
  before_filter :correct_admin, only: [:edit, :update, :pics, :picsupdate]
  before_filter :invite, only: [:new]
  skip_before_filter :authorize, only: [:show, :new]
  
  
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
      redirect_to @admin
    else
      render 'edit'
    end
  end
  
  def profile
    @admin = Admin.find(params[:id])
  end 
  
  def allmen
    @admin = Admin.find(params[:id]) 
  end
  
  def allwomen 
    @admin = Admin.find(params[:id])
  end
  
  def allmatches 
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
    
    
  
  private 
  
  def signed_in_admin
    unless signed_in? 
      store_location
      redirect_to login_path, notice: "Please Sign In."
    end
  end
  
  def correct_admin 
    @admin = Admin.find(params[:id])
    redirect_to(root_path) unless current_admin?(@admin)
  end

  
end
