class ChangeGoingKeys < ActiveRecord::Migration[5.2]
  def change
    drop_table :users_going_to_events

    create_table :users_going_to_events do |t|
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true

      t.timestamps
    end

    add_index :users_going_to_events, [:user, :events], unique: true
  end
end
