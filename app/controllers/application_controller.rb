class ApplicationController < ActionController::Base
  protect_from_forgery
  include AdminSessionsHelper

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
        unless Admin.find_by_id(session[:admin_id])
          redirect_to login_url, notice: "Please log in"
        end
      end
  
end
