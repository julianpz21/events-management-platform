module Types
  class EventType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :date, GraphQL::Types::ISO8601Date, null: false
    field :description, String, null: false
    field :place, String, null: false
    field :capacity, Integer, null: false
    field :category, Integer, null: false
    field :status, Integer, null: false
    field :user_id, ID, null: false
  end
end
