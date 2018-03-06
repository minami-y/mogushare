class TicketsMailer < ApplicationMailer
  default from: "mogushare.net@gmail.com"

  def send_mail_about_new_ticket(user, ticket)
    @user = user
    @share = ticket.shares.first

    mail to: @user.email
  end
end
