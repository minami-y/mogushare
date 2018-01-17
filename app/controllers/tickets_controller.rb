class TicketsController < ApplicationController
  layout 'after_signup_footer'
  before_action :register_as_seller, only: :new

  def index
    @user_areas = current_user.user_areas
  end

  def new
    @ticket = Ticket.new
    @ticket.shares.build
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      flash[:success] = "チケットを投稿しました"
      redirect_to tickets_path
    else
      render "new"
    end
  end

  def show
    @ticket = Ticket.find(params[:id])
    @shares = @ticket.shares
    @shares_price = @shares.sum(:price)
    @seller = @ticket.seller
  end

  private

    def ticket_params
      params.require(:ticket).permit(:message, :event_date, :expiration_date, :event_date, :event_place, shares_attributes: [:id, :genre, :menu, :price, :quantity, :ticket_id, :_destroy]).merge(seller_id: current_user.seller.id)
    end

    # チケット投稿ページに遷移時、販売者登録ができていなければ登録ページにリダイレクト
    def register_as_seller
      if current_user.seller.nil?
        redirect_to new_seller_path
      end
    end
end
