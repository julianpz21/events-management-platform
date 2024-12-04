module Mutations
  class DeleteEvent < BaseMutation
    argument :id, ID, required: true

    field :event, Types::EventType, null: true
    field :errors, [ String ], null: false

    def resolve(id:)
      event = Event.find(id)

      if event.update(status: :deleted)
        { event: event, errors: [] }
      else
        { event: event, errors: event.errors.full_messages }
      end
    end
  end
end
