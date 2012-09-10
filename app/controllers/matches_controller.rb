class MatchesController < ApplicationController
  skip_before_filter :authorize, excpet: [:index]
  
  def index
    @admin = current_admin
    @matches = Match.all
    @users = User.where(:admin_id => current_admin.id)
  end

  def new
    @match = Match.new
  end
  
  def create
    @match = Match.new(params[:matches])
  end

  def show
  end

  def edit
  end
  
  def update
  end
  
  def destroy
    @match = Match.find(params[:id])
    @match.destroy
    redirect_to matches_path
  end
  

end
