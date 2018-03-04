class SellersController < ApplicationController
  before_action :set_seller, only: [:edit, :update]

  def new
    @seller = Seller.new
  end

  def create
    @seller = Seller.new(seller_params)
    if @seller.save
      redirect_back_or new_ticket_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @seller.update_attributes(seller_params)
      flash[:success] = "購入者情報が更新されました"
      redirect_to user_path(current_user)
    end
  end

  private

    def set_seller
      @seller = Seller.find(current_user.seller.id)
    end

    def seller_params
      params.require(:seller).permit(:photo, :self_introduction, :sns_info).merge(user_id: current_user.id)
    end

end
