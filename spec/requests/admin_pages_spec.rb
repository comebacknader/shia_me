require 'spec_helper'

describe "AdminPages" do
  subject { page }
  
  describe "signup page" do
    before { visit signup_path }
    
    it { should have_selector('h1', text: 'Sign Up') }
    it { should have_selector('title', text: full_title('Sign Up')) }
  end 
  
  describe "admin show page" do
    let(:admin) { FactoryGirl.create(:admin) }
    before { visit admin_path(admin) }
    
    it { should have_selector('h1', text: admin.name) }
    it { should have_selector('title', text: admin.name) }
  end
end
