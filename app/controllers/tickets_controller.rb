class TicketsController < ApplicationController
  layout 'after_signup_footer'
  def index
    @user_areas = current_user.user_areas
    # @area = Area.where(postal_code: current_user.areas.postal_code)
    # @user = User.where(postal_code: 2150014).first
  end

  def new
    @ticket = Ticket.new
    @ticket.shares.build
  end

  def create
    binding.pry
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      flash[:success] = "チケットを投稿しました"
      redirect_to tickets_path
    else
      render "new"
    end
  end

  def show
  end

  private

    def ticket_params
      params.require(:ticket).permit(:message, :event_date, :expiration_date, :event_date, :event_place, shares_attributes: [:id, :genre, :menu, :price, :quantity, :ticket_id, :_destroy])
    end
end
