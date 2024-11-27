class Event < ApplicationRecord
  validates :name, :date, :description, :capacity, :category, :status, :place, presence: true

  enum status: { active: 0, deleted: 1, archived: 1 }
  enum category: { conference: 0, workshop: 1, webinar: 2, concert: 3, festival: 4, course: 5, networking: 6 }
end
