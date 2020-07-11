class Agian < ActiveRecord::Migration[5.2]
  def change
    remove_index :users_going_to_events, name: :index_users_going_to_events_on_user_and_events
    add_index :users_going_to_events, [:user, :events]
  end
end
