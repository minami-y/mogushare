class CommunitiesController < ApplicationController
  before_action :already_logged_in

  def index
  end

  def search
  end

  private

    def already_logged_in
      if logged_in?
        redirect_to tickets_path
      end
    end

end
