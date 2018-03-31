class TicketsMailer < ApplicationMailer
  default from: "mogushare.net@gmail.com"

  def send_mail_about_new_ticket(user, ticket)
    @user = user
    @ticket = ticket
    @shares = ticket.shares
    mail(
      subject: "【もぐシェア】新しい投稿があります",
      to: @user.email
    )
  end
end
