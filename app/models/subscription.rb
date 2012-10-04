class Subscription < ActiveRecord::Base
  attr_accessible :email, :name, :user_id, :stripe_card_token, :plan_id
  attr_accessor :stripe_card_token  
  belongs_to :user
   
	
  validates :name, presence: true,
                   length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, presence: true,
                    length: { maximum: 70 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }	
	
  
	def save_with_payment
	  if valid?
		customer = Stripe::Customer.create(description: email, plan: plan_id, 
											card: stripe_card_token)
		self.stripe_customer_token = customer.id
		save!
	  end
	rescue Stripe::InvalidRequestError => e
	  logger.error "Stripe error while creating customer: #{e.message}"
	  errors.add :base, "There was a problem with your credit card."
	  false
	end  
  
  
end
