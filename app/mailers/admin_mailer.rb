class AdminMailer < ApplicationMailer
  default from: 'admin@email.com'

  def creation_email(user, meeting)
    @user = user
    @meeting = meeting
    mail(
      subject: '予定承認の確認メール',
      to: @user.email
    )
  end
end
