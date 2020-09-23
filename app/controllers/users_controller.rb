class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def show
    @user = User.find(params[:id])
    @meetings = Meeting.where(user_id: @user.id).page(params[:page]).per(5)
    #本人と管理人のみ許可
    if @user.id != current_user.id
      unless current_user.admin?
        #ページがあることを知らせてしまうから表示しないほうがいいのかも
        redirect_to root_url, flash: {danger: 'アクセス権限がありません'}
      end
    end
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to meetings_url, flash: {success: "「#{@user.name}」さんようこそ"}
    else
      render :new
    end
  end


  private

    def user_params
      params.require(:user).permit(
        :name, :email, :password, :password_confirmation, :introduction
      )
    end
end
