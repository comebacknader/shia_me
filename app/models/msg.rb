class Msg < ActiveRecord::Base
  attr_accessible :admin_id, :message, :user_id
  
  belongs_to :admin
  belongs_to :user
  
end
