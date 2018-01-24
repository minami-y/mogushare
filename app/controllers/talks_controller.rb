class TalksController < ApplicationController
  def index
    @groups = current_user.groups
  end

  def show
  end
end
