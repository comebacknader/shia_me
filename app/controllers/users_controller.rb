class UsersController < ApplicationController
  skip_before_filter :authorize, except: [:assign, :assignmm, :match]
  before_filter :invite, only: [:new]
  before_filter :sign_this_user, only: [:index, :show, :edit, :update, :pics, :picsupdate]
  before_filter :correct_user, only: [:show, :edit, :update, :picsupdate]
  
  def index
    @users = User.all
  end
  
  def new
  	@admin = Admin.last
    @user = User.new(:admin_id => @admin.id)
  end
  
  def create
    @user = User.new(params[:user])

    if @user.save 
      sign_in_user @user
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
    @question = @user.question
    @match = @user.matches.last
    @wmatch = @user.wmatches.last
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(params[:user])
       flash[:notice] = "Successfully updated user."       
        sign_in_user @user
        redirect_to  @user
       else
     render :action => 'edit'
  	end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to current_admin
  end
  
  def profile
    @user = User.find(params[:id])
    @question = @user.question
    if @user.gender == "MALE"
    	@they = "He"
    else
    	@they = "She"
    end
  end
  
  def pics 
    @user = User.find(params[:id])
  end
  
  def picsupdate 
    @user = User.find(params[:id])
    if @user.update_attribute(:avatar, params[:user][:avatar])
     if params[:user][:avatar].blank?
      flash[:success] = "Picture Updated"
      sign_in_user @user      
	  redirect_to @user
     else 
      render :action => "crop"
     end
    else
      render 'pics'
    end
  end
  
  def crop
   @user = User.find(params[:id])
  end


  def cropupdate 
    @user = User.find(params[:id])
    @user.attributes = params[:user] 
	 if @user.save(:validate => false)
       if @user.cropping? 
    	@user.avatar.reprocess!       
        sign_in_user @user
        redirect_to  @user
       else
        sign_in_user @user
        render :action => 'crop'
       end 
    else 
       render :action => 'edit'
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
