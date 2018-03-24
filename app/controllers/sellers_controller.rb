class SellersController < ApplicationController
  before_action :set_seller, only: [:edit, :update]

  def new
    @seller = Seller.new
    # @seller.bank_account.build
  end

  def create
    @seller = Seller.new(seller_params)
    if @seller.save
      bank_account = @seller.bank_account

      # 支払い受け取り用のStripeアカウント作成
      account = Stripe::Account.create(
        type: "custom",
        country: "JP",
        email: @seller.user.email
      ) unless @seller.stripe_account_id.present?

      @seller.update(stripe_account_id: account.id)

      # Stripeへ銀行口座の登録
      bank = account.external_accounts.create({
        external_account: {
          account_number: @seller.bank_account.account_number.to_s,
          country: "JP",
          currency: "JPY",
          account_holder_name: @seller.bank_account.name,
          account_holder_type: "individual",
          routing_number: @seller.bank_account.bank_code.to_s + @seller.bank_account.branch_code.to_s,
          object: "bank_account"
        }
      })

      bank_account.update(bank_account_id: bank.id)

      redirect_back_or new_ticket_path
    else
      render 'new'
    end
  end

  def edit
    @seller.photo.cache! unless @seller.photo.blank?
  end

  def update
    if @seller.update_attributes(seller_params)
      flash[:success] = "購入者情報が更新されました"
      redirect_to tickets_path
    else
      render 'edit'
    end
  end

  private

    def set_seller
      @seller = Seller.find(current_user.seller.id)
    end

    def seller_params
      params.require(:seller).permit(:photo, :photo_cache, :self_introduction, :sns_info, bank_account_attributes: [:bank, :bank_code, :account_type, :branch_type, :branch_code, :account_number, :name]).merge(user_id: current_user.id)
    end

end
