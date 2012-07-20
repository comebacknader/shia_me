class ApplicationController < ActionController::Base
  protect_from_forgery
  include AdminSessionsHelper
  require 'net/HTTP'
  
  before_filter :browsercheck
  
  
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
  
end
