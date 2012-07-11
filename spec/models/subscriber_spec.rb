require 'spec_helper'

describe Subscriber do
  
  before { @subscriber = Subscriber.new(email: "subscriber@example.com") }
  subject { @subscriber }
  it { should respond_to(:email) }
  it { should be_valid }

  describe "when email is not present" do 
    before { @subscriber.email = " " }
    it { should_not be_valid }
  end
  
  describe "when email is too long" do 
    before { @subscriber.email = "a" * 61 }
    it { should_not be_valid }
  end
  
    describe "when email format is invalid" do 
      it "should not be invalid" do
      addresses = %w[subscriber@foo,com subscriber_at_foo.org example.subscriber@foo. 
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @subscriber.email = invalid_address
        @subscriber.should_not be_valid
      end
    end
  end
  
  describe "when email format is valid" do 
    it "should be valid" do 
      addresses = %w[subscriber@foo.COM SUB-SCRIBER@f.b.org S.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @subscriber.email = valid_address
        @subscriber.should be_valid
      end
    end
  end
  
  describe "when email address is already taken" do 
    before do
      subscriber_with_same_email = @subscriber.dup
      subscriber_with_same_email.email = @subscriber.email.upcase
      subscriber_with_same_email.save
    end
    it { should_not be_valid }
  end
  
end



# == Schema Information
#
# Table name: subscribers
#
#  created_at :datetime         not null
#  email      :string(255)
#  id         :integer          not null, primary key
#  updated_at :datetime         not null
#

