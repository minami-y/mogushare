class TicketsController < ApplicationController
  before_action :register_as_seller, only: :new
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def index
    @user_areas = current_user.user_areas
  end

  def new
    @ticket = Ticket.new
    @ticket.shares.build
  end

  def confirm
    @ticket = Ticket.new(ticket_params)
    @shares = @ticket.shares
    render :new if @ticket.invalid?
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.image.retrieve_from_cache! params[:cache][:image]
    if params[:back]
      render :new
    elsif @ticket.save!
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

  def edit
  end

  def update
    if @ticket.update(ticket_params)
      redirect_to ticket_path(@ticket.id)
    else
      render "edit"
    end
  end

  def destroy
    if @ticket.destroy
      redirect_to tickets_path, notice: 'チケットを削除しました。'
    end
  end

  private

    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    def ticket_params
      params.require(:ticket).permit(:image, :message, :image_cache, :event_date, :expiration_date, :event_date, :event_place, shares_attributes: [:id, :genre, :menu, :price, :quantity, :ticket_id, :_destroy]).merge(seller_id: current_user.seller.id)
    end

    # チケット投稿ページに遷移時、販売者登録ができていなければ登録ページにリダイレクト
    def register_as_seller
      if current_user.seller.nil?
        redirect_to new_seller_path
      end
    end
end
