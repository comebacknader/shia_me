class FeedsController < ApplicationController
  before_filter :authorize

  def index
    @feedable = find_feedable	
  	@feeds = @feedable.feeds
  end

  def show
  	@feed = Feed.find(params[:id])
  end

  def new
  	@feed = Feed.new
  end

  def create
   @feedable = find_feedable
   @feed = @feedable.feeds.build(params[:feed])
   @feed.admin_id = current_admin.id

  	if @feed.save 
  		redirect_to profile_admin_path(current_admin)
  	else
  		render 'new'
  	end
  end

  def edit
  	@feed = Feed.find(params[:id])
  end

  def destroy
  	@feed = Feed.find(params[:id])
  	@feed.destroy 
  	redirect_to profile_admin_path(current_admin)
  end

  private 

  def find_feedable
  params.each do |name, value|
    if name =~ /(.+)_id$/
      return $1.classify.constantize.find(value)
    end
  end
  nil
end

end
