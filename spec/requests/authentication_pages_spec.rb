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
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }
      
      describe "after visiting another page" do 
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end
    
    it { should have_selector('title', text: "Log In") }
    
    describe "with valid information" do 
      let(:admin) { FactoryGirl.create(:admin) }
      before { sign_in admin }
      
      it { should have_selector('title', text: admin.name) }
      it { should have_link('Profile', href: admin_path(admin)) }
      it { should have_link('Settings', href: edit_admin_path(admin)) }
      it { should have_link('Log Out', href: logout_path) }            
      it { should_not have_link('Log In', href: login_path) }
    end
  end  
  
  
  describe "authorization" do 
    
    describe "for non-signed-in admins" do 
      let(:admin) { FactoryGirl.create(:admin) }
      
      describe "In the Admins Controller" do 
        
        describe "visiting the edit page" do 
          before { visit edit_admin_path(admin) }
          it { should have_selector('title', text: 'Log In') }
        end
      
        describe "submitting to the update action" do 
          before { put admin_path(admin) }
          specify { response.should redirect_to(login_path) }
        end  
      end
    end
      
      describe "as wrong admin" do 
        let(:admin) { FactoryGirl.create(:admin) }
        let(:wrong_admin) { FactoryGirl.create(:admin, email: "wrong@example.com") }
        before { sign_in admin }
        
        describe "visiting Admin#edit page" do 
          before { visit edit_admin_path(wrong_admin) }
          it { should_not have_selector('title', text: full_title('Edit Profile')) }
        end
        
        describe "submitting a PUT request to the Admins#update action" do 
          before { put admin_path(wrong_admin) }
          specify { response.should redirect_to(root_path) }
        end      
    end
  end    
end
