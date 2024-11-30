class EventMailer < ApplicationMailer
  default from: "notifications@example.com"

  def event_notification_email
    @user = params[:user]
    @event = params[:event]
    mail(to: @user.email, subject: "Please attend Event")
  end
end
