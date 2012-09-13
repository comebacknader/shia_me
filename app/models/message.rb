class Message < ActiveRecord::Base
  attr_accessible :message, :reciever_id, :sender_id
  
  belongs_to :user
  
  
end
