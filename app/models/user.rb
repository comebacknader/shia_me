class User < ActiveRecord::Base
  attr_accessible :bio, :location, :name, :email, :gender, :password, 
  		:password_confirmation, :avatar, :admin_id, :age, 
  		:crop_x, :crop_y, :crop_w, :crop_h		
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h		
  has_secure_password
  
  belongs_to :admin
  
  has_one :question 

  has_one :mquest
  
  has_many :matches, foreign_key: "man_id", dependent: :destroy
  has_many :wmatches, foreign_key: "woman_id", class_name: "Match", dependent: :destroy
  has_many :man, through: :wmatches, source: "man_id"
  has_many :woman, through: :matches, source: "woman_id"
  
  has_many :messages, foreign_key: "sender_id", dependent: :destroy
  has_many :reciever, through: :messages, source: "reciever_id"
  
  has_many :recieved, foreign_key: "reciever_id", class_name: "Message", dependent: :destroy
  has_many :sender, through: :recieved, source: "sender_id"
 
  has_many :msgs, dependent: :destroy
  has_many :admins, through: :msgs
 
  
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  
  validates :name, presence: true,
                   length: { maximum: 50 },
                   on: :create

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true,
                    length: { maximum: 70 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false },
                    on: :create
  
  validates :gender, presence: true, on: :create
  
  validates :password, presence: true,
                       length: { minimum: 6 },
                       on: :create
  
  validates :password_confirmation, presence: true, on: :create
  
  
  has_attached_file :avatar, :styles => { :small =>"125x125>", :medium =>"250x250>", 
  															 :large => "450x450>" },
  			  :processors => [:cropper], 											 
              :storage => :s3, 
              :bucket => 'userphotos.shiame.com',
              :s3_credentials => {
              :access_key_id => ENV['S3_KEY_SHIAME'],
              :secret_access_key => ENV['S3_SECRET_SHIAME']            
            }
  
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
