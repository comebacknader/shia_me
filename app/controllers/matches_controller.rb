class MatchesController < ApplicationController
  
  def index
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
  end
  
end
