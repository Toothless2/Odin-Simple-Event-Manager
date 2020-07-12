class AllowUsersInEventToBeNull < ActiveRecord::Migration[5.2]
  def up
    remove_column :events, :users
  end

  def down
    add_column :events, :users, foreign_key: true
  end
end
