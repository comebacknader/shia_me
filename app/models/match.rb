class Match < ActiveRecord::Base
  attr_accessible :man_id, :woman_id, :reason
  
  belongs_to :man, class_name: "User"
  belongs_to :woman, class_name: "User"
  
end
