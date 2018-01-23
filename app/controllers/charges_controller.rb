class ChargesController < ApplicationController

  def new
    @ticket = Ticket.find(params[:id])
    @amount = @ticket.shares.sum(:price)
  end

  def create
    @ticket = Ticket.find(params[:id])
    @amount = @ticket.shares.sum(:price) * 100

    customer = Stripe::Customer.create(
      :email  => params[:stripeEmail],
      :source => params[:stripeToken]
      )

    charge = Stripe::Charge.create(
      :customer => customer.id,
      :amount => @amount,
      :description => 'Rails Stripe customer',
      :currency => 'jpy'
      )
    @ticket.update_attributes(buyer_id: params[:buyer_id])
    redirect_to talks_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
