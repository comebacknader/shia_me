class Subscription < ActiveRecord::Base
  attr_accessible :email, :name
  
  belongs_to :user
  
end
