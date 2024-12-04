module Mutations
  class CreateEvent < BaseMutation
    argument :name, String, required: true
    argument :date, GraphQL::Types::ISO8601Date, required: true
    argument :description, String, required: true
    argument :place, String, required: true
    argument :capacity, Integer, required: true
    argument :category, Integer, required: true

    field :event, Types::EventType, null: true
    field :errors, [ String ], null: false

    def resolve(name:, date:, description:, place:, capacity:, category:)
      event = User.find(context[:current_user].id).events.build(name: name, date: date,
        description: description, place: place, capacity: capacity, category: category)

      if event.save
        { event: event, errors: [] }
      else
        { event: nil, errors: event.errors.full_messages }
      end
    end
  end
end
