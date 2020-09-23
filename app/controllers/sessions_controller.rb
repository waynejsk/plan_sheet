class SessionsController < ApplicationController
  skip_before_action :require_login

  def new
  end

  def create
    @user = User.find_by(email: session_params[:email])

    if @user&.authenticate(session_params[:password])
      log_in @user
      redirect_to meetings_url, flash: {success: "#{@user.name}さんがログインしました"}
    else
      flash.now[:danger] = 'メールアドレスまたはパスワードが間違っています'
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to login_url, flash: {success: 'ログアウトしました'}
  end

  private
    def session_params
      params.require(:session).permit(:email, :password)
    end
end
