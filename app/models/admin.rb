class Admin < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :bio, :location, :avatar
  has_secure_password
  
  has_many :users
  
  has_many :msgs
  has_many :users, :through => :msgs
  
  before_save { |admin| admin.email = email.downcase }
  before_save :create_remember_token
  
  validates :name, presence: true,
                   length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true,
                    length: { maximum: 70 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  validates :password, presence: true,
                       length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  has_attached_file :avatar, :styles => { :small =>"125x125>", :large =>"350x350>" },
              :storage => :s3, 
              :bucket => 'adminphotos.shiame.com',
              :s3_credentials => {
              :access_key_id => ENV['S3_KEY_SHIAME'],
              :secret_access_key => ENV['S3_SECRET_SHIAME']
            }
  
  
  private
  
    def create_remember_token 
      self.remember_token = SecureRandom.urlsafe_base64
    end
  
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