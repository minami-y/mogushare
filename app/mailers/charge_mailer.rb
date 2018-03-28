class ChargeMailer < ApplicationMailer
  default from: "mogushare.net@gmail.com"

  def send_mail_when_charged(user, seller, order)
    @user = user
    @seller = seller
    @oder_details = order.order_details

    mail to: @seller.user.email
  end
end
