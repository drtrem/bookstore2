class UserMailer < ActionMailer::Base
  default from: "website@zzz.com"
  def send_enabled_message(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to Pixel Technologies!!!")
  end
  def send_new_user_message(user)
    @user = user
    mail(:to => user.email, :subject => "New User created please review and enable.")
  end
end