class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

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
    # @user = User.find(params[:id])
  end

  def edit
  end

  def update
    binding.pry
    if @user.update_attributes(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
    end

end
