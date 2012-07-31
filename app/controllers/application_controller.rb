class ApplicationController < ActionController::Base
  protect_from_forgery
  include AdminSessionsHelper
  include UsersessionsHelper

  before_filter :authorize
  
    def browsercheck
          @browser = request.env["HTTP_USER_AGENT"]
          if @browser["MSIE 6.0"]  
            render "pages/oldbrowser"
          else if  @browser["MSIE 7.0"]
            render "pages/oldbrowser"
          else
            nil
        end
      end
    end
    
    def authorize 
        unless current_admin
          redirect_to login_url, notice: "Please log in"
        end
      end
      
    def user_authorize
      unless current_user
        redirect_to signin_url, notice: "Please Sign In"
      end
    end
      
    def invitecode 
      unless Invite.find_by_code(params[:code])
        redirect_to root_path
      else
        session[:code] = Invite.find_by_code(params[:code])
        redirect_to new_user_url
      end
    end
    
    def invite
      unless session[:code]
        redirect_to root_path
      end
    end
  
end
