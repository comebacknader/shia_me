class User < ActiveRecord::Base
  attr_accessible :bio, :location, :name, :email, :gender, :password, 
  		:password_confirmation, :avatar, :admin_id, :age, :free,
  		:crop_x, :crop_y, :crop_w, :crop_h, :updating_password		
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :updating_password
  	
  serialize :already, Array
    
  has_secure_password
  
  belongs_to :admin
  
  has_one :question 

  has_one :mquest
  
  has_one :subscription
  
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
                   length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true,
                    length: { maximum: 70 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  validates :gender, presence: true
  
  validates :password, presence: true,
                       length: { minimum: 6 }, 
                       :if => :password_validation_required?
  
  validates :password_confirmation, presence: true, 
  				     :if => :password_validation_required?
  
  
  has_attached_file :avatar, :styles => { :small =>"125x125>", :medium =>"250x250>", 
  															 :large => "450x450>" },
  			  :processors => [:cropper], 											 
              :storage => :s3, 
              :bucket => 'userphotos.shiame.com',
              :s3_credentials => {
              :access_key_id => ENV['S3_KEY_SHIAME'],
              :secret_access_key => ENV['S3_SECRET_SHIAME']            
            }
  


  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

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
