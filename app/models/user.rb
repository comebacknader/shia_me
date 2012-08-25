class User < ActiveRecord::Base
  attr_accessible :bio, :location, :name, :email, :gender, :password, :password_confirmation, :avatar, :admin_id
  has_secure_password
  
  belongs_to :admin
  
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  
  validates :name, presence: true,
                   length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true,
                    length: { maximum: 70 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  validates :gender, presence: true
  
  validates :password, presence: true,
                       length: { minimum: 6 }
  
  validates :password_confirmation, presence: true
  
  has_attached_file :avatar, :styles => { :small =>"125x125>", :medium =>"250x250>", :large => "450x450>" },
              :storage => :s3, 
              :bucket => 'userphotos.shiame.com',
              :s3_credentials => {
              :access_key_id => ENV['S3_KEY_SHIAME'],
              :secret_access_key => ENV['S3_SECRET_SHIAME']
            }
  
  private
  
    def create_remember_token 
      self.remember_token = SecureRandom.urlsafe_base64
    end
  
end
