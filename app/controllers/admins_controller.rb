class AdminsController < ApplicationController
  
  def index
    @admins = Admin.all
  end

  def new
  end

  def show
    @admin = Admin.find(params[:id])
  end

  def edit
  end
  
end
