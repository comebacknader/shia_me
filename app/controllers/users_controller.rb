class UsersController < ApplicationController
  
  skip_before_filter :authorize
  
  def new
  end
  
  
end
