class UserMailer < ApplicationMailer
  def welcome_email user
    @url = 'http://localhost:3000'
    @user = user
    mail(to: @user.email, subject: 'Welcome to OdinFacebook!')
  end
end
