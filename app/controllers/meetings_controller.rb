class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]
  
  def index
    @meetings = Meeting.page(params[:page]).per(5).order(updated_at: :desc)
  end

  def new
    @meeting = Meeting.new
  end

  def create
    @meeting = Meeting.new(meeting_params)
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

  private

    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    def meeting_params
      params.require(:meeting).permit(:start_time, :label, :detail)
    end
end
