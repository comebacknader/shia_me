module ApplicationHelper
  
  include AdminSessionsHelper
  include UsersessionsHelper
  include MsgsHelper
  
  
  def full_title(page_title) 
    base_title = "shiaME"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  
  def metacontent 
    base_description = "shiaMe is a Premium MatchMaking Service for Shia Muslims" 
    if @description.nil?
      base_description
    else
      "#{@description}"
    end
  end
  
end
