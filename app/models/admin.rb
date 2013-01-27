class Admin < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, 
  				  :bio, :location, :avatar, :crop_x, :crop_y, :crop_h,
  				  :crop_w, :updating_password, :ethnicity
  attr_accessor :crop_x, :crop_y, :crop_h, :crop_w, :updating_password			  
  has_secure_password
  
  has_many :users
    
  has_many :msgs
  has_many :users, :through => :msgs

  has_many :feeds
  has_many :feeds, :as => :feedable, :dependent => :destroy 

  has_many :mmsgs, foreign_key: "sender_id", dependent: :destroy
  has_many :receiver, through: :mmsgs, source: "receiver_id"
  
  has_many :received, foreign_key: "receiver_id", class_name: "Mmsg", dependent: :destroy
  has_many :sender, through: :received, source: "sender_id"


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
                       length: { minimum: 6 },
                       :if => :password_validation_required?
                       
  validates :password_confirmation, presence: true,
		    :if => :password_validation_required?
  
  has_attached_file :avatar, :styles => { :small =>"125x125>", :large =>"350x350>" },
  			  :processors => [:cropper],   
              :storage => :s3, 
              :bucket => 'adminphotos.shiame.com',
              :s3_credentials => {
              :access_key_id => ENV['S3_KEY_SHIAME'],
              :secret_access_key => ENV['S3_SECRET_SHIAME']
            }
  
  def password_validation_required?
	 updating_password || new_record?
  end
  
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  def avatar_geometry(style = :original)
   @geometry ||= {}
   avatar_path = (avatar.options[:storage] == :s3) ? avatar.url(style) : avatar.to_file(style)
   @geometry[style] ||= Paperclip::Geometry.from_file(avatar_path)
  end   
  
  
  private
  
  def reprocess_avatar
  	avatar.reprocess!
  end  
  
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