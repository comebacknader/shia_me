class ApplicationController < ActionController::Base
  protect_from_forgery
  include AdminSessionsHelper
  include UsersessionsHelper
  include MsgsHelper

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
      if Invite.find_by_code(params[:code])
        session[:code] = Invite.find_by_code(params[:code])
        redirect_to new_user_url
      else if  
        params[:code] == "MatchMaker4Mahdi"
        session[:code] = "MatchMaker4Mahdi"
        redirect_to new_admin_url
      else if 
        params[:code] == "freeshiauser"
        session[:code] = "freeshiauser"
        redirect_to freeuser_path
      else
        redirect_to root_path
      end
     end
     end
    end
    
    def invite
      unless session[:code]
        redirect_to root_path
      end
    end


    def paid
      if current_user.free == true or current_user.free == nil
        redirect_to current_user, :notice => "Welcome!"
      else
        nil
      end
    end

    def notpaid
      unless current_user.free == true or current_user.subscription.present? 
        redirect_to new_user_subscription_path(@user) 
      else
        nil
      end
    end
  
    def alreadypaid 
      if current_user
       if current_user.subscription.present? 
         redirect_to current_user, :notice => "You Already Paid"
       end
      else
        redirect_to root_path
      end
    end
  
end
