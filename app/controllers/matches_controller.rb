class MatchesController < ApplicationController
  skip_before_filter :authorize, except: [:index]
  before_filter :admin_not_seen_msg, only: [:index]
  before_filter :user_in_match, only: [:deletematch]
  
  def index
    @admin = current_admin
    @matches = Match.all
    @male_users = User.where(:admin_id => current_admin.id, :gender => "MALE")
    @female_users = User.where(:admin_id => current_admin.id, :gender => "FEMALE")    
    @users = []
    @matched_users = []
    @male_users.each do |user|
      unless user.matches.present?
       @users << user
      else
       @matched_users << user
      end
    end
    @female_users.each do |user|
      unless user.wmatches.present? 
        @users << user
      else
        @matched_users << user
      end
    end
  end

  def new
    @match = Match.new
  end
  
  def create
    @match = Match.new(params[:matches])
  end

  def show
  	@match = Match.find(params[:id])
  	@user = @match.man

    if @user.gender == "MALE"
      @matcher = @match.woman
    else if @user.gender == "FEMALE"
      @matcher = @wmatch.man 
    end
    end 
  end

  def edit
  end
  
  def update
  end
  
   def approvefem 
  	@user = current_user
  	@match = Match.find(params[:id])
  	@match.update_attribute("femapprove", "true")
  	redirect_to @user
  end	 
  
  
  def approveinfo 
  	@user = current_user
  	@match = Match.find(params[:id])
  	@match.update_attribute(:infoapprove, "true")
  	redirect_to @user
  end	

  def approvepic 
  	@user = current_user
  	@match = Match.find(params[:id])
  	@match.update_attribute(:picapprove, "true")
  	redirect_to @user
  end	  
  
  
  def destroy   
    @match = Match.find(params[:id])

    @usr = User.find(@match.man_id)
    @messages = @usr.messages
		@messages.each do |message|
			message.destroy
		end
    @recieved = @usr.recieved
		@recieved.each do |recieve|
			recieve.destroy
		end
    
    @match.destroy
    
    if current_user
    redirect_to current_user 
    else
    redirect_to profile_admin_path(current_admin)
    end
  end


    def deletematch
    @user = current_user

     if @user.gender == "MALE"
      @match = current_user.matches.last
      @matcher = @match.woman
    else if @user.gender == "FEMALE"
      @match = current_user.wmatches.last      
      @matcher = @match.man 
    end
    end    
  end   
  

private 

 def user_in_match 
  @match = Match.find(params[:id])
  if @match.man.id == current_user.id || @match.woman.id == current_user.id
    if @match.femapprove.blank? && @match.man.id == current_user.id
      redirect_to current_user
    else
    end
  else
    redirect_to current_user
  end
end 


end
