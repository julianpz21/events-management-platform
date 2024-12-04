module Mutations
  class RegisterEvent < BaseMutation
    argument :event_id, ID, required: true

    field :enrollment, Types::EnrollmentType, null: true
    field :errors, [ String ], null: false

    def resolve(event_id:)
      enrollment = Enrollment.new(user_id: context[:current_user].id, event_id: event_id)

      if enrollment.save
        { enrollment: enrollment, errors: [] }
      else
        { enrollment: enrollment, errors: enrollment.errors.full_messages }
      end
    end
  end
end
