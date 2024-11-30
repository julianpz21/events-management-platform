class EventNotificationJob < ApplicationJob
  queue_as :default

  def perform(user, event)
    EventMailer.with(user: user, event: event).event_notification_email.deliver_now
  end
end
