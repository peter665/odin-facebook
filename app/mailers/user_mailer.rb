class UserMailer < ApplicationMailer
  def welcome_email user
    @url = Rails.env.development? ? 'http://localhost:3000' : 'https://odin-facebook11.herokuapp.com'
    @user = user
    mail(to: @user.email, subject: 'Welcome to OdinFacebook!')
  end
end
