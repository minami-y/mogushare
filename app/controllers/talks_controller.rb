class TalksController < ApplicationController

  def index
    @groups = current_user.groups
  end

  def show
    @group = Group.find(params[:id])
    @talk = Talk.new
    @talk_logs = @group.talks
  end

  def create
    @talk = current_user.talks.create(talk_params)
    redirect_to :back if @talk.save
  end

  private
    def talk_params
      params.require(:talk).permit(:group_id, :user_id, :message)
    end
end
