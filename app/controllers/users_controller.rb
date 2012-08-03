class UsersController < ApplicationController
  
  skip_before_filter :authorize
  before_filter :invite, only: [:new]
  before_filter :sign_this_user, only: [:index, :show, :edit]
  before_filter :correct_user, only: [:edit, :update]
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])

    if @user.save 
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile Updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
  end
  
  def profile
    @user = User.find(params[:id])
  end
  
  def pics 
    @user = User.find(params[:id])
  end
  
  def picsupdate 
    @user = User.find(params[:id])
    
    if @user.update_attribute(:avatar, params[:user][:avatar])
      flash[:success] = "Picture Updated"
      redirect_to @user
    else
      render 'pics'
    end
  end
  
  private 

   def sign_this_user
     unless signed_in_user? 
       store_this_location
       redirect_to signin_path, notice: "Please Sign In."
     end
   end

   def correct_user 
     @user = User.find(params[:id])
     redirect_to(root_path) unless current_user?(@user)
   end
  
  
end
