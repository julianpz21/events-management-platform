# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Event
    can :register, Event
    can :unregister, Event
    can :create, Event if user.admin?

    if user.admin?
      can [ :update, :delete, :archive ], Event, user_id: user.id
    end
  end
end
