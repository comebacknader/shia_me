# == Schema Information
#
# Table name: admins
#
#  created_at :datetime         not null
#  email      :string(255)
#  id         :integer          not null, primary key
#  name       :string(255)
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Admin do
  
  before { @admin = Admin.new(name: "Admin", email: "example@admin.com") }
  subject { @admin }
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should be_valid } # when there is a "be" in front of a something
                        # there is a boolean on it - this case @admin.valid?
  
  describe "when admin name not present" do
    before { @admin.name = " " }
    it { should_not be_valid }
    end 
    
    describe "admin name not over 50" do 
      before { @admin.name = "a" * 51 }
      it { should_not be_valid }
    end
    
    describe "when admin email not present" do
      before { @admin.email = " " }
      it { should_not be_valid }
    end
    
    describe "admin email not over 70" do
      before { @admin.email = "a" * 71 }
      it { should_not be_valid }
     end 
    
    describe "invalid email address" do 
      it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                           foo@bar_baz.com foo@bar+baz.com]  
      addresses.each do |address|
        @admin.email = address
        @admin.should_not be_valid
      end
    end
  end
    
    describe "valid email address" do 
      it "should be valid" do 
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |address|
        @admin.email = address
        @admin.should be_valid
        end
      end
    end
 
  describe "email should not have duplicate" do
    before do 
      admin_with_same_email = @admin.dup
      admin_with_same_email.email = @admin.email.upcase
      admin_with_same_email.save
    end
    it { should_not be_valid }
  end
    
    
end
