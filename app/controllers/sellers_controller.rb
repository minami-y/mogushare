class SellersController < ApplicationController
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
  end

  private

    def seller_params
      params.require(:seller).permit(:official_name, :address, :phone_number).merge(user_id: current_user.id)
    end

end
