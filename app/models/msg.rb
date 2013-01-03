class Msg < ActiveRecord::Base
  attr_accessible :admin_id, :message, :user_id, :seen, :user_hide, :admin_hide
  
  belongs_to :admin
  belongs_to :user


  
end
