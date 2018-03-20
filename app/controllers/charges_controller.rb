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
    @order.summed_price = @order.total_price
    @ticket = Ticket.find(params[:id])

    return  render template: "tickets/#{@ticket.id}/show" if params[:back]

      # 在庫を減らす。
      @order.order_details.each do |od|
        @share = Share.find(od.share_id)
        @share.quantity -= od.quantity
        @share.save
      end

      # stripeによる決済処理
      calculator = BillCalculator.new(
        current_user,
        @order.total_price,
        params[:invitation_code],
        params[:used_point].to_i,
      )
      @order.total_price = calculator.amount

      @order.save!
      if current_user.stripe_customer_id.present?
        customer_id = current_user.stripe_customer_id
      else
        customer = Stripe::Customer.create(
          email: params[:stripeEmail],
          source: params[:stripeToken]
        )
        current_user.update(stripe_customer_id: customer.id)
        customer_id = customer.id
      end

      raise '決済に失敗しました' unless current_user.stripe_customer_id.present? && @ticket.seller.stripe_account_id.present?

      charge = Stripe::Charge.create({
        amount: @order.total_price,
        currency: "jpy",
        customer: customer_id,
        destination: {
          account: @ticket.seller.stripe_account_id,
        }
      })
      # @ticket.update_attributes(buyer_id: params[:buyer_id])

      calculator.apply!

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
          redirect_to thanks_path(id: @ticket.id)
        else
          @group = Group.create(group_params)
          @user_group_seller = UserGroup.create(group_id: @group.id, user_id: @ticket.seller.user.id)
          logger.debug @user_group_seller.errors.inspect
          @user_group_buyer = UserGroup.create(group_id: @group.id, user_id: params[:buyer_id])
          redirect_to thanks_path(id: @ticket.id)
        end
      else
        @group = Group.create(group_params)
        @user_group_seller = UserGroup.create(group_id: @group.id, user_id: @ticket.seller.user.id)
        logger.debug @user_group_seller.errors.inspect
        @user_group_buyer = UserGroup.create(group_id: @group.id, user_id: params[:buyer_id])
        redirect_to thanks_path(id: @ticket.id)
      end

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end

  def thanks
    @ticket = Ticket.find(params[:id])
    @seller = @ticket.seller
    @group = current_user.groups.joins(:users).where(users:{id: @ticket.seller.user.id}).first
  end

  private

    def order_params
      params.require(:order).permit(:seller_id, :user_id, :total_price, order_details_attributes: [:id, :share_id, :order_id, :unit_price, :quantity, :price, :_destroy])
    end

    def group_params
      params.permit(user_ids: [])
    end
end
