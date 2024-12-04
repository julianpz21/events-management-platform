module Mutations
  class UpdateEvent < BaseMutation
    argument :id, ID, required: true
    argument :name, String, required: true
    argument :date, GraphQL::Types::ISO8601Date, required: true
    argument :description, String, required: true
    argument :place, String, required: true
    argument :capacity, Integer, required: true
    argument :category, Integer, required: true


    field :event, Types::EventType, null: true
    field :errors, [ String ], null: false

    def resolve(id:, name:, date:, description:, place:, capacity:, category:)
      event = Event.find(id)

      if event.update(name: name, date: date, description: description, place: place, capacity: capacity, category: category)
        { event: event, errors: [] }
      else
        { event: event, errors: event.errors.full_messages }
      end
    end
  end
end
