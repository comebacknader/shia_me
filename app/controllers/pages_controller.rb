class PagesController < ApplicationController
  
  def home
    @subscriber = Subscriber.new
  end
  
  def about 
   @subscriber = Subscriber.new
   @browser = request.env["HTTP_USER_AGENT"]
  end
  
  def signin
  end
  
end
