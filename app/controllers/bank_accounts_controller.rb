class BankAccountsController < ApplicationController
  before_action :set_bank_account, only: [:edit, :update]
  def new
    seller = Seller.find(current_user.seller.id)
    @bank_account = BankAccount.new
  end

  def create
    @bank_account = current_user.seller.create_bank_account(bank_account_params)
    if @bank_account.save

      account = Stripe::Customer.retrieve(current_user.seller.stripe_account_id)
      bank_account = @seller.bank_account
      if @seller.bank_account
        account.external_accounts.create({
          external_account: {
            account_number: @seller.bank_account.account_number.to_s,
            country: "JP",
            currency: "JPY",
            account_holder_name: @seller.bank_account.name,
            account_holder_type: "individual",
            routing_number: @seller.bank_account.bank_code + @seller.bank_account.branch_code,
            object: "bank_account"
          }
        })
      end
      flash[:success] = "口座情報が登録されました"
      redirect_to user_path(current_user)
    else
      render 'new'
    end
    rescue Stripe::InvalidRequestError,
      Stripe::AuthenticationError,
      Stripe::APIConnectionError,
      Stripe::StripeError ,
      Stripe::CardError => e
    #stripe側でNGなので@bank_accountsを削除
      logger.debug(e.inspect)
      @bank_account.delete
      flash[:alert] = e.message
      render 'new'
  end

  def edit
  end

  def update
    if @bank_account.update_attributes(bank_account_params)
      flash[:success] = "口座情報が更新されました"
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
  end

    private
      def set_bank_account
        @bank_account = BankAccount.find(current_user.seller.bank_account.id)
      end

      def bank_account_params
        params.require(:bank_account).permit(
          :bank,
          :bank_code,
          :account_type,
          :branch_type,
          :branch_code,
          :account_number,
          :name,
          :identification,
          :photo_cache).merge(seller_id: current_user.seller.id)
      end

end