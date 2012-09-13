class MessagesController < ApplicationController
	skip_before_filter :authorize

	def index
    @messages = Message.all
	@user = current_user
    @match = @user.matches.last
    @wmatch = @user.wmatches.last
	end
	
	def show
	  @message = Message.find(params[:id])
	end
	
	def new
	  @message = Message.new
	end
	
	def create
	  @message = Message.new(params[:message])
	  
	  if @message.save 
	  	redirect_to @message
	  else
	  	render 'new'
	  end
	end
	
	def edit
	  @message = Message.find(params[:id])
	end
	
	def update
	  @message = Message.find(params[:id])

     if @message.update_attributes(params[:message])
       redirect_to @message
     else
       render 'edit'
     end
	end
	
	def destroy
	 @message = Message.find(params[:id])
	 @message.destroy
	 redirect_to @message
	end

end
