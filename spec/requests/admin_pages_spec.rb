require 'spec_helper'

describe "AdminPages" do
  subject { page }
  
  before { AdminsController.skip_before_filter :authorize }
  
  
  describe "index page" do 
    before do 
      sign_in FactoryGirl.create(:admin)
      FactoryGirl.create(:admin, name: "Bob", email: "bob@bobample.com")
      FactoryGirl.create(:admin, name: "Ben", email: "ben@benample.com")
      visit admins_path
    end
    
    it { should have_selector('title', text: "All Admins") }  
    it { should have_selector('h1', text: "All Admins") } 
    
    it "should list all admins" do 
      Admin.all.each do |admin|
        page.should have_selector('p', text: admin.name)
      end
    end
  end
     
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
      
        describe "after saving the user" do 
          before { click_button submit }
          let(:admin) { Admin.find_by_email('ali@akbar.com') } 
          
          it { should have_selector('title', text: admin.name) }
          it { should have_selector('div.alert.alert-success', text: "Welcome") }
          it { should have_link('Log Out', ahref: logout_path )}
        end
    end
    
    describe "edit Admin" do 
      let(:admin) { FactoryGirl.create(:admin) }
      before do
        sign_in admin
        visit edit_admin_path(admin) 
      end 
      
      describe "page" do 
        it { should have_selector('h1',     text: "Edit Profile") }
        it { should have_selector('title',  text: "Edit Admin") }
      end
      
      describe "with invalid information" do 
        before { click_button "Save" }
        
        it { should have_content('error') }
      end
      
      describe "with valid information" do 
        let(:new_name) { "New Name" }
        let(:new_email){ "new@example.com" }
        before do 
          fill_in "Name",             with: new_name
          fill_in "Email",            with: new_email
          fill_in "Password",         with: admin.password
          fill_in "Confirmation",     with: admin.password
          click_button "Save"
        end
        
        it { should have_selector('title', text: new_name) }
        it { should have_selector('div.alert.alert-success') }
        it { should have_link('Log Out', href: logout_path) }
        specify { admin.reload.name.should == new_name }
        specify { admin.reload.email.should == new_email }
      end      
    end    
  end   
end
