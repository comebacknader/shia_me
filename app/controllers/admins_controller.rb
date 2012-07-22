class AdminsController < ApplicationController
  before_filter :signed_in_admin
  before_filter :correct_admin, only: [:edit, :update]
  skip_before_filter :authorize
  
  
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
      redirect_to @admin
    else
      render 'edit'
    end
  end
  
  private 
  
  def signed_in_admin
    redirect_to login_path, notice: "Please Sign In." unless signed_in?
  end
  
  def correct_admin 
    @admin = Admin.find(params[:id])
    redirect_to(root_path) unless current_admin?(@admin)
  end
  
end
