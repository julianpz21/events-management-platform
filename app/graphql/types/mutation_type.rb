# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_event, mutation: Mutations::CreateEvent
    field :update_event, mutation: Mutations::UpdateEvent
    field :archive_event, mutation: Mutations::ArchiveEvent
    field :delete_event, mutation: Mutations::DeleteEvent
    field :register_event, mutation: Mutations::RegisterEvent
    field :Unregister_event, mutation: Mutations::UnregisterEvent
  end
end
