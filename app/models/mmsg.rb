class Mmsg < ActiveRecord::Base
  attr_accessible :message, :receiver_hide, :receiver_id, :receiver_seen, :sender_hide, :sender_id, :sender_seen


  belongs_to :sender, class_name: "Admin"
  belongs_to :receiver, class_name: "Admin"

end
