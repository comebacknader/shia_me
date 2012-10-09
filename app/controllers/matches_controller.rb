class MatchesController < ApplicationController
  skip_before_filter :authorize, except: [:index]
  
  def index
    @admin = current_admin
    @matches = Match.all
    @users = User.where(:admin_id => current_admin.id)
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
    redirect_to current_admin
    end
  end
  

end
