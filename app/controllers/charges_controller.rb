class ChargesController < ApplicationController

  def confirm
    @order = Order.new(order_params)
    @order_details = @order.order_details
    @ticket = Ticket.find(params[:id])
    @amount = @order.total_price
  end

  def create
    # orderを保存
    @order = Order.new(order_params)
    @ticket = Ticket.find(params[:id])
    if params[:back]
      render template: "tickets/#{@ticket.id}/show"
    elsif @order.save!
      # 在庫を減らす。
      @order.order_details.each do |od|
        @share = Share.find(od.share_id)
        @share.quantity -= od.quantity
        @share.save
      end

      # stripeによる決済処理
      @amount = @order.total_price * 100

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
      # @ticket.update_attributes(buyer_id: params[:buyer_id])

      # 同じ購入者と販売者が属するgroupがない場合はgroupを作成する。
      if current_user.groups.exists?
        groups = current_user.groups
        array = []
        groups.each do |group|
          group.user_groups.each do |user_group|
            array << user_group.user_id
          end
        end
        if array.include?(@ticket.seller.user.id)
          redirect_to talks_path
        else
          @group = Group.create(group_params)
          @user_group_seller = UserGroup.create(group_id: @group.id, user_id: @ticket.seller.user.id)
          logger.debug @user_group_seller.errors.inspect
          @user_group_buyer = UserGroup.create(group_id: @group.id, user_id: params[:buyer_id])
          redirect_to thanks_path
        end
      else
        @group = Group.create(group_params)
        @user_group_seller = UserGroup.create(group_id: @group.id, user_id: @ticket.seller.user.id)
        logger.debug @user_group_seller.errors.inspect
        @user_group_buyer = UserGroup.create(group_id: @group.id, user_id: params[:buyer_id])
        redirect_to thanks_path
      end
    else
      render template 'tickets/show'
    end

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end

  def thanks
  end

  private

    def order_params
      params.require(:order).permit(:seller_id, :user_id, :total_price, order_details_attributes: [:id, :share_id, :order_id, :unit_price, :quantity, :price, :_destroy])
    end

    def group_params
      params.permit(user_ids: [])
    end
end
