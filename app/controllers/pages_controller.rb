class PagesController < ApplicationController
  skip_before_filter :authorize, only: [:home, :about]
  
  def home
    @subscriber = Subscriber.new
  end
  
  def about 
   @subscriber = Subscriber.new
   @browser = request.env["HTTP_USER_AGENT"]
  end
  
  def signin
  end
  
  def invite 
    @subscriber = Subscriber.new
  end
  
end
