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
    @group = Group.create(group_params)
    @user_group_seller = UserGroup.create(group_id: @group.id, user_id: params[:seller_id])
    @user_group_buyer = UserGroup.create(group_id: @group.id, user_id: params[:buyer_id])
    redirect_to talks_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  private

    def group_params
      params.permit(user_ids: [])
    end
end
