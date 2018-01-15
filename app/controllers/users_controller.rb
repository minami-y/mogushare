class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ユーザー登録が完了しました"
      # 仮置き　実際はタイムラインにリダイレクト
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールが更新されました"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    # ログイン済みユーザーかどうかを確認する
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end

    # 正しいユーザーかどうかを確認する
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
    end

end
