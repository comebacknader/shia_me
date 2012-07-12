class Admin < ActiveRecord::Base
  attr_accessible :email, :name
  
  validates :name, presence: true,
                   length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true,
                    length: { maximum: 70 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
end


# == Schema Information
#
# Table name: admins
#
#  created_at :datetime         not null
#  email      :string(255)
#  id         :integer          not null, primary key
#  name       :string(255)
#  updated_at :datetime         not null
#