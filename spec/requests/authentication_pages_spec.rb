require 'spec_helper'

describe "AuthenticationPages" do
  
  subject { page }
  
  describe "signin page" do 
    before { visit login_path }
    
    it { should have_selector('h1', text: 'Log In') }
    it { should have_selector('title', text: 'Log In') }    
  end
  
    describe "signin" do 
      before { visit login_path }
      
    describe "with invalid information" do 
      before { click_button "Log In" }  
      
      it { should have_selector('title', text: 'Log In') }
      it { should have_selector('div.error.alert-error', text: 'Invalid') }
      
      describe "after visiting another page" do 
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end
    
      it { should have_selector('title', text: "Log In") }
    
    describe "with valid information" do 
      let(:admin) { FactoryGirl.create(:admin) }
      before do 
        fill_in "Email",      with: admin.email
        fill_in "Password",   with: admin.password
        click_button "Log In"
      end
      
      it { should have_selector('title', text: admin.name) }
      it { should have_link('Profile', href: admin_path(admin)) }
      it { should have_link('Log Out', href: logout_path) }            
      it { should_not have_link('Log In', href: login_path) }
    end
    
  end    
end
