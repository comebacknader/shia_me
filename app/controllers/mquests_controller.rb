class MquestsController < ApplicationController
	skip_before_filter :authorize

  def index
  	@mquests = Mquest.all
  end

  def new
	@user = current_user	
	@match = @user.matches.last
	@wmatch = @user.wmatches.last 
	@question = current_user.question	  
	@newmessages = @user.recieved.where(:seen => "false")	
  	@mquest = Mquest.new(:user_id => @user.id)
  end
  
  def create 
  	@mquest = Mquest.new(params[:mquest])
  	
  	if @mquest.save 
  		redirect_to current_user
  	else 
  	    render 'new'
  	end
  end

  def show
	@mquest = Mquest.find(params[:id])	
  end

  def edit
 	@user = current_user	
	@match = @user.matches.last
	@wmatch = @user.wmatches.last 
	@question = current_user.question	
	@newmessages = @user.recieved.where(:seen => "false") 
    @mquest = Mquest.find(params[:id])
  end
  
  def update 
  	@mquest = Mquest.find(params[:id])
  	
  	if @mquest.update_attributes(params[:mquest])
  		redirect_to current_user
  	else
  		render 'edit'
  	end
  end
  
  def destroy
  	@mquest = Mquest.find(params[:id])
  	@mquest.destroy
  	redirect_to current_user
  end
  
end
