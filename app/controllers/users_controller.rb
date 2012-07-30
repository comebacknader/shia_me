class UsersController < ApplicationController
  
  skip_before_filter :authorize
  before_filter :invite, only: [:new]
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])

    if @user.save 
      redirect_to user_path
    else
      render 'new'
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
  end

  def destroy
  end
  
end
