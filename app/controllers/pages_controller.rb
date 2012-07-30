class PagesController < ApplicationController
  skip_before_filter :authorize, only: [:home, :about, :invite, :test]
  before_filter :invitecode, only: [:test]
  
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
  end
  
  def test
  end
  
end
