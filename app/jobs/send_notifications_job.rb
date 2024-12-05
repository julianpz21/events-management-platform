class SendNotificationsJob < ApplicationJob
  queue_as :default

  def perform
    EventNotificationService.call
  end
end
