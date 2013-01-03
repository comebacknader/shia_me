class MmsgsController < ApplicationController
 before_filter :authorize
 before_filter :admin_not_seen_msg

  def index
  	@mmsgs = Mmsg.all
  end

  def show
  	@mmsg = Mmsg.find(params[:id])
  end

  def new
  	@mmsg = Mmsg.new
  end

  def edit
  	@mmsg = Mmsg.find(params[:id])
  end
end
