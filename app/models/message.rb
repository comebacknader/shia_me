class Message < ActiveRecord::Base
  attr_accessible :message, :reciever_id, :sender_id, :seen
  
  belongs_to :sender, class_name: "User"
  belongs_to :reciever, class_name: "User"
  
  validates :message, presence: true
  
end
