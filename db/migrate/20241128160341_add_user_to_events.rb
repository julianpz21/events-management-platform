class AddUserToEvents < ActiveRecord::Migration[7.2]
  def change
    add_reference :events, :user
  end
end
