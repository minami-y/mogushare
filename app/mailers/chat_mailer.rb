class ChatMailer < ApplicationMailer
  default from: "mogushare.net@gmail.com"

  def send_mail_about_new_chat(user, group, current_user)
    @user = user
    @current_user = current_user
    @group = group
    mail to: @user.email
  end
end
