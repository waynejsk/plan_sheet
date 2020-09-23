class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:edit, :update, :destroy]
  before_action :set_meeting_others_can_see, only: [:show, :send_email]
  
  def index
    @meetings = current_user.meetings.page(params[:page]).per(5).order(updated_at: :desc)
  end

  def new
    @meeting = Meeting.new
  end

  def create
    @meeting = current_user.meetings.new(meeting_params)
    if @meeting.save
      redirect_to meetings_url, flash: {success: "#{@meeting.label}を作成しました"}
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @meeting.update(meeting_params)
      redirect_to meetings_url, flash: {success: "#{@meeting.label}を更新しました"}
    else
      render :edit
    end
  end

  def destroy
    @meeting.destroy!
    redirect_to meetings_url, flash: {danger: "#{@meeting.label}を削除しました"}
  end

  def send_email
    @user = User.find_by(id: @meeting.user_id)
    AdminMailer.creation_email(@user, @meeting).deliver_now
    redirect_to meeting_path(@meeting), flash: {success: 'メールを送信しました'}
  end

  private
    def set_meeting
      @meeting = current_user.meetings.find(params[:id])
    end

    def set_meeting_others_can_see
      @meeting = Meeting.find(params[:id])
      #作成者と管理人のみ許可
      if @meeting.user_id != current_user.id
        unless current_user.admin?
          #ページがあることを知らせてしまうから表示しないほうがいいのかも
          redirect_to root_url, flash: {danger: 'アクセス権限がありません'}
        end
      end
    end

    def meeting_params
      params.require(:meeting).permit(:start_time, :label, :detail, :user_id)
    end
end
