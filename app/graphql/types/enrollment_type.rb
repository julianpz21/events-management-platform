module Types
  class EnrollmentType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, ID, null: false
    field :event_id, ID, null: false
    field :notified, Boolean, null: false
  end
end
