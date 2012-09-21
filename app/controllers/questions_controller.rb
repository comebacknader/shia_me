class QuestionsController < ApplicationController
	skip_before_filter :authorize

  def index
	@questions = Question.all
  end

  def new
	@user = current_user	
	@match = @user.matches.last
	@wmatch = @user.wmatches.last 
  	@question = Question.new(:user_id => @user.id)
  end
  
  def create
  	@question = Question.new(params[:question])
  	
  	if @question.save 
  	   redirect_to profile_user_path(current_user)
  	else 
  		render 'new'
  	end
  end
  
  def show
  	@question = Question.find(params[:id])
  end

  def edit
	@user = current_user	
	@match = @user.matches.last
	@wmatch = @user.wmatches.last   
  	@question = Question.find(params[:id])
  end
  
  def update
  	@question = Question.find(params[:id])
  	
  	if @question.update_attributes(params[:question])
  		redirect_to profile_user_path(current_user)
  	else
  		render 'edit'
  	end
  end
  
  def destroy
  	@question = Question.find(params[:id])
  	@question.destroy
  	redirect_to current_user
  end
  
end
