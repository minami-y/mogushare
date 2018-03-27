class TalksController < ApplicationController

  def index
    @groups = current_user.groups
  end

  def show
    @group = Group.find(params[:id])
    @talk = Talk.new
    @talk_logs = @group.talks
    @group.users.each do |user|
      if user.name != current_user.name
        @else_user = user
      end
    end
  end

  def create
    @talk = current_user.talks.create(talk_params)
    if @talk.save
      send_mail_to_group_user(@talk)
      redirect_to :back
    end
  end

  private
    def talk_params
      params.require(:talk).permit(:group_id, :user_id, :message)
    end

    def send_mail_to_group_user(talk)
      group = talk.group
      group_users = group.users
      group_users.each do |user|
        ChatMailer.send_mail_about_new_chat(user, group) unless user.id == current_user.id
      end
    end
end


