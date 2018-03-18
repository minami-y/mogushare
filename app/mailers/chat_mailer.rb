class ChatMailer < ApplicationMailer
  default from: "mogushare.net@gmail.com"

  def send_mail_about_new_chat(user, group)
    @user = user
    @group = group

    mail to: @user.email, subject: "Mail from mogushare"

  end
end
