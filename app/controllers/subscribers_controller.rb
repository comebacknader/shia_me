class SubscribersController < ApplicationController
 skip_before_filter :authorize, except: [:index]
 
  def new
    @subscriber = Subscriber.new
  end
  
  def index
    @subscribers = Subscriber.all
  end
  
  def create
    @subscriber = Subscriber.new(params[:subscriber])
    
    if @subscriber.save
      redirect_to "/thankyou", :notice => "You Are On the Email List"
    else
      redirect_to root_path
    end
  end
  
  def edit
    @subscriber = Subscriber.find(params[:id])
  end
  
  def update
    @subscriber = Subscriber.find(params[:id])
    
    if @subscriber.update_attributes(params[:subscriber])
      render subscribers_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @subscriber = Subscriber.find(params[:id])
    @subscriber.destroy
    redirect_to root_path
  end
  
  def thankyou
  end
  
end
