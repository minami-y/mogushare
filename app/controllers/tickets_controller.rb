class TicketsController < ApplicationController
  before_action :register_as_seller, only: :new
  before_action :set_ticket, only: [:show, :edit, :edit_confirm, :update, :destroy]

  def index
    @user_areas = current_user.user_areas
    @shares = []
    @user_areas.each do |ua|
      ua.area.users.each do |user|
        if user.seller.present?
          user.seller.tickets.each do |ticket|
            ticket.shares.each do |share|
              if ticket.expiration_date > Time.current && share.quantity != 0
                @shares << share
              end
            end
          end
        end
      end
    end
  end

  def new
    @ticket = Ticket.new
    @ticket.shares.build
  end

  def confirm
    @ticket = Ticket.new(ticket_params)
    @shares = @ticket.shares
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if params[:back]
      render :new
    elsif @ticket.save!
      send_mail_to_users_in_area
      flash[:success] = "チケットを更新しました"
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
    # orderインスタンスを生成
    @order = Order.new
    @order.order_details.build
  end

  def edit
    @shares = @ticket.shares
    @shares.each do |share|
      share.image.cache! unless share.image.blank?
    end
  end

  def edit_confirm
    # @ticket = Ticket.new(ticket_params)
    @ticket.attributes = ticket_params
    @shares = @ticket.shares
  end

  def update
    if @ticket.update(ticket_params)
      redirect_to user_path(current_user.id)
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
      params.require(:ticket).permit(:genre, :event_date, :expiration_date, :event_date, :event_end_date, :event_place, shares_attributes: [:id, :image, :image_cache, :menu, :price, :quantity, :message, :ticket_id, :_destroy]).merge(seller_id: current_user.seller.id)
    end

    # チケット投稿ページに遷移時、販売者登録ができていなければ登録ページにリダイレクト
    def register_as_seller
      if current_user.seller.nil?
        redirect_to new_seller_path
      elsif current_user.seller.bank_account.nil?
        redirect_to new_seller_path
      end
    end

    def send_mail_to_users_in_area
      user_areas = UserArea.where(user_id: @ticket.seller.user_id)
      user_areas.each do |user_area|
        TicketsMailer.send_mail_about_new_ticket(user_area.user, @ticket).deliver_later unless @ticket.seller.user_id == user_area.user_id
      end
    end
end
