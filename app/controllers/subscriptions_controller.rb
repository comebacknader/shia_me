class SubscriptionsController < ApplicationController
	skip_before_filter :authorize
	before_filter :alreadypaid, :only => [:new]


  def index
  end

  def new
  	@user = current_user
 	@match = @user.matches.last
	@wmatch = @user.wmatches.last  
	@question = current_user.question	
  	@subscription = Subscription.new(:user_id => @user.id, :plan_id => 1)
    @newmessages = @user.recieved.where(:seen => "false")  	
  end
  
  def create
  	@user = current_user
  	@question = current_user.question
	@subscription = Subscription.new(params[:subscription])
	
	if @subscription.save_with_payment
	 redirect_to @user, :notice => "Thank you for your Monthly Subscription!"
	else
	 render 'new'
	end
  end

  def show
   @subscription = Subscripton.find(params[:id])
  end

  def edit
     @subscription = Subscripton.find(params[:id])
  end
  
  
end
