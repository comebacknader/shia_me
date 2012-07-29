class Invite < ActiveRecord::Base
  attr_accessible :code
  
  
  private 
  
  def self.search(search)
    if search == Invite.find_by_code("#{search}")
      return true
    else
      nil
    end
  end
  
end
