class AdminMailer < ActionMailer::Base
  default from: "nader@shiame.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin_mailer.admin_reset.subject
  #
  def admin_reset(admin)
    @admin = admin
    mail :to => admin.email, :subject => "Password Reset"
  end

  def saba_users(user)
    @user = user
    @home = "http://www.shiame.com"    
    mail :to => @user, :subject => "shiaME Invitation"
  end

end
