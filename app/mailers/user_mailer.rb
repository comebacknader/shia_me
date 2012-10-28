class UserMailer < ActionMailer::Base
  default from: "nader@shiame.com"


  def welcome(user)
  	mail(to: user.email, subject: "Welcome to shiaME")
  end
  
end
