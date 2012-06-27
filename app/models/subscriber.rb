class Subscriber < ActiveRecord::Base
  attr_accessible :email
  
  before_save { |subscriber| subscriber.email = email.downcase }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true, length: { maximum: 60 }, 
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
end



# == Schema Information
#
# Table name: subscribers
#
#  created_at :datetime         not null
#  email      :string(255)
#  id         :integer          not null, primary key
#  updated_at :datetime         not null
#

