class UsersController < ApplicationController
  
  skip_before_filter :authorize
  before_filter :invitecode
  
  def new
  end
  
  
end
