require 'spec_helper'

describe "Pages Controller Tests" do
  
  subject { page }
  
  describe "Home Page" do
    before { visit root_path}
    
    it { should have_selector('title', text: full_title('')) }    
    it { should_not have_selector('title', :text => '| Home') }                          
  
  end
  
  describe "About Page" do
    before { visit about_path }
    
    it {should have_selector('title', text: full_title('')) }                   
  end
end
