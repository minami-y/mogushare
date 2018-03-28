class ChargeMailer < ApplicationMailer
  default from: "mogushare.net@gmail.com"

  def send_mail_when_charged(user, seller, order, group)
    @user = user
    @seller = seller
    @oder_details = order.order_details
    @group = group

    mail to: @seller.user.email
  end
end
