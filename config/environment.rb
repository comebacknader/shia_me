# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
ShiaMe::Application.initialize!

  if Rails.env.production? 
    Stripe.api_key = ENV['STRIPE_API_KEY']
  end