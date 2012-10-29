class UserMailer < ActionMailer::Base
  default from: "nader@shiame.com"


  def welcome(user)
  	@user = user
  	@signin = "http://www.shiame.com/signin"
  	mail(to: user.email, subject: "Welcome to shiaME")
  end

end
