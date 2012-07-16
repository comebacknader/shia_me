class PagesController < ApplicationController
  
  def home
    @subscriber = Subscriber.new
  end
  
  def about 
   @subscriber = Subscriber.new
  end
  
  def signin
  end
  
end
