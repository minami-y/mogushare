class SharesController < ApplicationController
  def destroy
    @share = Share.find(params[:id])
    unless @share.order_details.present?
      if @share.destroy
        redirect_to user_path, notice: 'メニューを削除しました'
      end
    else redirect_to user_path, notice: '既に購入されたメニューは削除できません'
    end
  end
end
