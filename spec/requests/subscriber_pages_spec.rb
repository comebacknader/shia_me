require 'spec_helper'

describe "SubscriberPages" do
  
  subject { page }
  
  describe "SIGN UP PAGE" do
    before { visit thankyou_path }
 
    it { should have_selector('h1', text: 'Thank You') }
    it { should have_selector('title', text: full_title('')) }

  end
end
