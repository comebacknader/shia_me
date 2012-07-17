require 'spec_helper'

describe "AdminPages" do
  subject { page }
  
  describe "signup page" do
    before { visit new_admin_path }
    
    it { should have_selector('h1', text: 'Become A MatchMaker') }
    it { should have_selector('title', text: full_title('Sign Up')) }
  end 
  
  describe "admin show page" do
    let(:admin) { FactoryGirl.create(:admin) }
    before { visit admin_path(admin) }
    
    it { should have_selector('h1', text: admin.name) }
    it { should have_selector('title', text: admin.name) }
  end
  
  describe "signup" do 
    before { visit new_admin_path }
    
    let(:submit) { "Sign Up" }
    
    describe "with invalid information" do 
      it "should not create an Admin" do 
        expect { click_button submit }.not_to change(Admin, :count)
      end
    end
    
    describe "with valid information" do
      before do 
        fill_in "Name",         with: "Ali Akbar"
        fill_in "Email",        with: "ali@akbar.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      
      it "should create Admin" do
        expect { click_button submit }.to change(Admin, :count).by(1)
      end
    end
  end   
end
