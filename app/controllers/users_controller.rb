class UsersController < ApplicationController
  include AdminsHelper
  skip_before_filter :authorize, except: [:assign, :assignmm, :match]
  before_filter :invite, only: [:new, :freeuser]
  before_filter :sign_this_user, only: [:index, :show, :edit, :update, :pics, :picsupdate]
  before_filter :correct_user, only: [:show, :edit, :update, :picsupdate]
  before_filter :retrieve_newmsg, only: [:show]
  before_filter :admin_not_seen_msg, only: [:assign, :match]
  before_filter :matched_users, only: [:match, :only, :assign]
  before_filter :notpaid, only: [:show, :edit]
  

  def index
    @users = User.all
  end
  
  def new
      @user = User.new
  end
  
  def create
    @user = User.new(params[:user])

    if @user.save 
      if @user.gender == "FEMALE"
        redirect_to permission_user_path(@user)
      else 
        UserMailer.welcome(@user).deliver      
      	sign_in_user @user
        redirect_to pick_user_path(@user)
      end	
    else
      render 'new'
    end
  end
  
  def show
   @user = User.find(params[:id])
     unless @user.admin.present? 
      if @user.free == true
        redirect_to pick_user_path(@user)
      else
       redirect_to new_user_subscription_path(@user)
      end
     else
      @question = @user.question
      @match = @user.matches.last
      @wmatch = @user.wmatches.last
       if @match || @wmatch
        unless @user.gender == "MALE"
    	    @admin = Admin.where(:id => @wmatch.admin_id).last
        else
    	    @admin = Admin.where(:id => @match.admin_id).last
        end
       end
        @newmessages = @user.recieved.where(:seen => "false")
     end
   @mquest = Mquest.where(:user_id => @user.id)
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
    if @user.subscription.present?  
     @subscription = @user.subscription  
     @stripe = Stripe::Customer.retrieve(@subscription.stripe_customer_token)
     @stripe.delete
    end
    @user.destroy
    if current_admin
     flash[:notice] = "Successfully deleted #{@user.name}"       
     redirect_to profile_admin_path(current_admin)
    else
     redirect_to root_path
    end
  end
  
  def profile
    @user = User.find(params[:id])
    @match = @user.matches.last
    @wmatch = @user.wmatches.last  
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
	 if @user.update_attributes(params[:user])
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
  
  def pick
  	@user = User.find(params[:id])
    @admins = []
  	@all = Admin.all
    @all.each do |admin|
      unless admin.email == "comebacknader@hotmail.com"
        @admins << admin
      end
    end
  end
  
  def pickmm
    @user = User.find(params[:id])
    if @user.update_attribute(:admin_id, params[:user][:admin_id])
      flash[:success] = "MatchMaker Assigned"
      sign_in_user @user
      redirect_to new_user_subscription_path(@user)
    else
      render 'pick'
    end  
  end
  
  def match 
    @admin = current_admin
    @user = User.find(params[:id])
    @match = Match.new
    @men = []
    @women = []
    if @user.gender == "FEMALE"
      @allmen = User.where(:gender => "MALE").order("name ASC")
      @allmen.each do |men|
       if men.matches.empty? 
        @men << men
       end
      end
    else
      @allwomen = User.where(:gender => "FEMALE").order("name ASC") 
      @allwomen.each do |women|
        if women.wmatches.empty?
          @women << women
        end
      end
    end
  end
  
  def makematch
    @user = User.find(params[:id])
    @already = @user.already
    @match = Match.new(params[:match])
    
    if @match.save
      if @user.gender == "FEMALE"
        @user.already << @match.man.name
        @user.save
      else 
        @user.already << @match.woman.name
        @user.save
      end
      redirect_to matches_path
    else
      render 'match'
    end
  end
  
  def permission
  	@user = User.find(params[:id])
  end
  
  def gotpermit
  	@user = User.find(params[:id])
  	
  	if @user.update_attribute("permission", params[:user][:permission])
  	 sign_in_user @user
     redirect_to pick_user_path(@user)
  	else
  	 render :action => "permission"
  	end	  	
  end

  def freeuser
   unless session[:code] == "freeshiauser"
      redirect_to root_path
    else
     @user = User.new
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
