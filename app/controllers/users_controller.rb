class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :already_logged_in, only: [:new, :create]

  def new
    @user = User.new
    @area = Area.search(params[:search])
    if @area.nil?
      flash[:danger] = "正しい郵便番号を入力してください"
      redirect_to index_path
    end
  end

  def create
    # facebook認証でのサインアップ
    if env['omniauth.auth'].present?
      @user = User.from_omniauth(env['omniauth.auth'])
      result = @user.save(context: :facebook_login)
      fb = "Facebook"
    else
      #　通常のサインアップ
      @user = User.new(user_params)
      @area = Area.find(params[:area_id])
      if params.require(:user)[:accepted] == "1"
        result = @user.save
        fb = ""
      else
        flash[:danger] = "利用規約に同意して下さい"
      end
    end

    if result
      log_in @user
      @user_area = UserArea.create(user_id: @user.id, area_id: params[:area_id])
      # 仮置き　実際はタイムラインにリダイレクト
      redirect_to tickets_path
    else
      if fb.present?
        redirect_to auth_failure_path
      else
        render "new"
        # redirect_to signup_path(params[:search])
        # redirect_to root_path
      end
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

  def buy_history
    @orders = Order.where(user_id: current_user.id)
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

    def already_logged_in
      if logged_in?
        redirect_to tickets_path
      end
    end

    # 正しいユーザーかどうかを確認する
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :accepted)
    end
end
