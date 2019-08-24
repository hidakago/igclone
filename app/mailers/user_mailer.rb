class UserMailer < ApplicationMailer
  def post_notification_mail(user)
    @user = user
    mail to: @user.email, subject: "投稿の通知メール"
  end
end
