class UsersController < ApplicationController
  skip_before_filter :authorize, except: [:assign, :assignmm, :match]
  before_filter :invite, only: [:new]
  before_filter :sign_this_user, only: [:index, :show, :edit, :update, :pics, :picsupdate]
  before_filter :correct_user, only: [:show, :edit, :update, :picsupdate]
  
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
    @match = @user.matches.last
    @wmatch = @user.wmatches.last
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
  
  def assign
    @admin = current_admin
    @user = User.find(params[:id])  
    @users = User.where(:admin_id => current_admin.id)
  end
  
  def assignmm 
    @admin = current_admin
    @user = User.find(params[:id])
    if @user.update_attribute(:admin_id, params[:user][:admin_id])
      flash[:success] = "MatchMaker Assigned"
      redirect_to profile_user_path
    else
      render 'assign'
    end
  end
  
  def match 
    @admin = current_admin
    @users = User.where(:admin_id => current_admin.id)
    @user = User.find(params[:id])
    @match = Match.new
  end
  
  def makematch
    @match = Match.new(params[:match])
    
    if @match.save
      redirect_to matches_path
    else
      render 'match'
    end
  end
    
  def deletematch
  	@user = current_user
  	@match = @user.matches.last
    @wmatch = @user.wmatches.last
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
