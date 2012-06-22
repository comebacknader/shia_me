require 'spec_helper'

describe "Pages Controller Tests" do
  
  describe "Home Page" do
    
    it "should have the right title" do
      visit '/pages/home'
      page.should have_selector('title',
                                :text => 'shiaME')
    end
    
    it "should not have custom page title" do
    visit '/pages/home'
    page.should_not have_selector('title',
                                  :text => '| Home')
    end                           
  end
  
  describe "About Page" do
    
    it "should have the h1 About Text" do 
      visit '/pages/about'
      page.should have_selector('h1', :text => "About")
    end
    
    it "should have Title of About" do 
      visit '/pages/about'
      page.should have_selector('title',
                                :text => 'shiaME | About')
    end                    
  end
end
