module Mutations
  class UnregisterEvent < BaseMutation
    argument :event_id, ID, required: true

    field :enrollment, Types::EnrollmentType, null: true
    field :errors, [ String ], null: false

    def resolve(event_id:)
      enrollment = Enrollment.find_by(user_id: context[:current_user].id, event_id: event_id)

      if enrollment
        enrollment.destroy
        { enrollment: enrollment, errors: [] }
      else
        { enrollment: nil, errors: [ "register not found" ] }
      end
    end
  end
end
