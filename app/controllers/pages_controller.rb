class PagesController < ApplicationController
  
  def home
    @title = "Home"
    @subscriber = Subscriber.new
  end
  
  def about 
  end
  
end
