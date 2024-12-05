class EventNotificationService < ApplicationService
  def initialize
    @start_date = Date.current
    @end_date = Date.current + 2.days
  end

  def call
    send_mailers
    update_enrollments
  end

  private

  def send_mailers
    enrollments.find_each(batch_size: 100) do |enrollment|
      EventNotificationJob.perform_later(enrollment.user, enrollment.event)
    end
  end

  def enrollments
    enrollments ||= Enrollment.includes(:event, :user).where(
      notified: false, event: { date: @start_date..@end_date, status: :active }
    )
  end

  def update_enrollments
    enrollments.update_all(notified: true)
  end
end
