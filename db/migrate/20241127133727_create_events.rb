class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.date :date, null: false
      t.text :description, null: false
      t.string :place, null: false
      t.integer :capacity, null: false
      t.integer :category, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
