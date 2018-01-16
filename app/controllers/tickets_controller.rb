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

  def show
  end
end
