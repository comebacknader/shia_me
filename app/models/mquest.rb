class Mquest < ActiveRecord::Base
  attr_accessible :agerange, :anypref, :edulevel, :ethnic, :needhijabi, :user_id
  
  belongs_to :user
  
end
