class MessagesController < ApplicationController
	skip_before_filter :authorize

	def index
		@user = current_user	
		@match = @user.matches.last
		@wmatch = @user.wmatches.last
		@messages = @user.messages
		@recieved = @user.recieved
	end
	
	def show
	  @message = Message.find(params[:id])
 	  @messages = Message.all
	  @user = current_user
	  @match = @user.matches.last
	  @wmatch = @user.wmatches.last	  
	end
	
	def new
		@user = current_user
		@match = @user.matches.last
		@wmatch = @user.wmatches.last
			if @user.gender == "MALE"
				@message = Message.new(:reciever_id => @match.woman.id, 
									   :sender_id => @user.id)
			else 
				@message = Message.new(:reciever_id => @wmatch.man.id,
									   :sender_id => @user.id)
			end    	 	
		@lastmessage = @match.woman.messages.last
		@msg = @wmatch
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

	def sent
		@user = current_user	
		@match = @user.matches.last
		@wmatch = @user.wmatches.last
		@messages = @user.messages
		@recieved = @user.recieved
	end

end
