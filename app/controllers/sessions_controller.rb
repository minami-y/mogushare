class SessionsController < ApplicationController
  def new
  end

  def create
    if env['omniauth.auth'].present?
      user = User.from_omniauth(env["omniauth.auth"])
      log_in user
      redirect_to tickets_path
    else
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        # ログイン後、アクセスしようとしていたページにリダイレクトする。
        # redirect_back_or user
        redirect_to tickets_path
      else
        flash.now[:danger] = 'invalid'
        render 'new'
      end
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
