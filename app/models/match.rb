class Match < ActiveRecord::Base
  attr_accessible :man_id, :woman_id, :reason, :femreason, :admin_id, :femapprove, :infoapprove, :picapprove
  
  belongs_to :man, class_name: "User"
  belongs_to :woman, class_name: "User"

  belongs_to :admin
  
end
