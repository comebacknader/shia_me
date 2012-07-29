class Invite < ActiveRecord::Base
  attr_accessible :code
  
  
  private 
  
  def self.search(search)
    search.present? 
  end
  
end
