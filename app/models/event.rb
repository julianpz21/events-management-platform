class Event < ApplicationRecord
  belongs_to :user
  has_many :enrollments

  enum status: { active: 0, deleted: 1, archived: 2 }
  enum category: { conference: 0, workshop: 1, webinar: 2, concert: 3, festival: 4, course: 5, networking: 6 }

  validates :name, :date, :description, :capacity, :category, :status, :place, presence: true
  validate :only_past_events_can_be_archived, if: :status_will_change_to_archived?
  validate :only_future_events_can_be_delete, if: :status_will_change_to_deleted?

  private

  def only_past_events_can_be_archived
    if date >= Date.current
      errors.add(:status, "only past events can by archived")
    end
  end

  def only_future_events_can_be_delete
    if date <= Date.current
      errors.add(:status, "only future events can by deleted")
    end
  end

  def status_will_change_to_archived?
    status_changed?(from: :active, to: :archived)
  end

  def status_will_change_to_deleted?
    status_changed?(from: :active, to: :deleted)
  end
end
