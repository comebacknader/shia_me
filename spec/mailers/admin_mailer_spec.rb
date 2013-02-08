require "spec_helper"

describe AdminMailer do
  describe "admin_reset" do
    let(:mail) { AdminMailer.admin_reset }

    it "renders the headers" do
      mail.subject.should eq("Admin reset")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
