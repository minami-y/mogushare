class SellersController < ApplicationController
  before_action :set_seller, only: [:edit, :update]

  def new
    if current_user.seller.present?
      redirect_to action: :edit, id: current_user.seller
    else
      @seller = Seller.new
    end
    # @seller.bank_account.build
  end

  def create
    @seller = Seller.new(seller_params)
    if @seller.save
      # 支払い受け取り用のStripeアカウント作成
      account = Stripe::Account.create(
        type: "custom",
        country: "JP",
        email: @seller.user.email,
        legal_entity: {
          address_kana: {
            state: @seller.address_kana_state,
            city: @seller.address_kana_city,
            town: @seller.address_kana_town,
            line1: @seller.address_kana_line,
            postal_code: @seller.postal_code
          },
          address_kanji: {
            state: @seller.address_kanji_state,
            city: @seller.address_kanji_city,
            town: @seller.address_kanji_town,
            line1: @seller.address_kanji_line,
            postal_code: @seller.postal_code
          },
          dob: {
            day: @seller.date_of_birth.day,
            month: @seller.date_of_birth.month,
            year: @seller.date_of_birth.year
          },
          first_name_kana: @seller.first_name_kana,
          first_name_kanji: @seller.first_name_kanji,
          last_name_kana: @seller.last_name_kana,
          last_name_kanji: @seller.last_name_kanji,
          phone_number: @seller.phone_number,
          gender: @seller.gender,
          type: "individual",
        },
        tos_acceptance: {
          date: Time.now.to_i,
          ip: request.remote_ip
        }
      ) unless @seller.stripe_account_id.present?
      @seller.stripe_account_id = account.id
      @seller.save
      # Stbank_account = @seller.bank_account
      # bank = account.external_accounts.create({
      #   external_account: {
      #     account_number: @seller.bank_account.account_number.to_s,
      #     country: "JP",
      #     currency: "JPY",
      #     account_holder_name: @seller.bank_account.name,
      #     account_holder_type: "individual",
      #     routing_number: @seller.bank_account.bank_code + @seller.bank_account.branch_code,
      #     object: "bank_account"
      #   }
      # })


      # @seller.bank_account.bank_account_id = bank.id
      # bank_account.save
      redirect_back_or new_ticket_path
    else
      render 'new'
    end
    rescue Stripe::InvalidRequestError,
       Stripe::AuthenticationError,
       Stripe::APIConnectionError,
       Stripe::StripeError ,
      Stripe::CardError => e
      #stripe側でNGなので@sellerを削除
      @seller.delete
      flash[:alert] = e.message
      render 'new'
  end

  def edit
    # @seller.photo.cache! unless @seller.photo.blank?
  end

  def update
    if @seller.update_attributes(seller_params)
      flash[:success] = "プロフィールが更新されました"
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
  end

  private

    def set_seller
      @seller = Seller.find(current_user.seller.id)
    end

    def seller_params
      params.require(:seller).permit(
        :photo,
        :photo_cache,
        :self_introduction,
        :sns_info,
        :address_kana_state,
        :address_kana_city,
        :address_kana_town,
        :address_kana_line,
        :postal_code,
        :address_kanji_state,
        :address_kanji_city,
        :address_kanji_town,
        :address_kanji_line,
        :date_of_birth,
        :date_of_birth,
        :date_of_birth,
        :first_name_kana,
        :first_name_kanji,
        :last_name_kana,
        :last_name_kanji,
        :phone_number,
        :gender
      ).merge(user_id: current_user.id)
    end

end
