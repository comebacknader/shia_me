class MessagesController < ApplicationController
	skip_before_filter :authorize
	before_filter :retrieve_newmsg 

	def index
		@user = current_user	
		@match = @user.matches.last
		@wmatch = @user.wmatches.last
		@messages = @user.messages.order('created_at DESC').limit(20)
		@recieved = @user.recieved.order('created_at DESC').limit(20)
		@newmessages = @user.recieved.where(:seen => "false")
		@msgs = @user.msgs.order('created_at DESC').limit(10)
		@question = current_user.question
	end
	
	def show
	  @message = Message.find(params[:id])
 	  @messages = Message.all
	  @user = current_user
	  @newmessages = @user.recieved.where(:seen => "false")	  
 	  @question = @user.question	  
	  @match = @user.matches.last
	  @wmatch = @user.wmatches.last	
	  
	  if @message.reciever_id == @user.id
	   if @message.seen = "false" 
	     @message.update_attribute(:seen, "true")
	   end
	  end
	    
	end
	
	def new
	@user = current_user
	@question = @user.question
	@newmessages = @user.recieved.where(:seen => "false")	
	@match = @user.matches.last
		unless @match == nil
			@lastmessage = @match.woman.messages.last
		end		
	@wmatch = @user.wmatches.last
		unless @wmatch == nil
			@msg = @wmatch.man.messages.last
		end
		if @user.gender == "MALE"
			@message = Message.new(:reciever_id => @match.woman.id, 
								   :sender_id => @user.id, :seen => "false")
		else 
			@message = Message.new(:reciever_id => @wmatch.man.id,
								   :sender_id => @user.id, :seen => "false")
		end    	 	
	end
	
	def create
	  @message = Message.new(params[:message])
	  
	  if @message.save 
	  	redirect_to messages_path
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
		@question = @user.question
		@match = @user.matches.last
		@wmatch = @user.wmatches.last
		@newmessages = @user.recieved.where(:seen => "false")		
		@messages = @user.messages.order('created_at DESC').limit(5)
		@recieved = @user.recieved.order('created_at DESC').limit(5)
	end

end
