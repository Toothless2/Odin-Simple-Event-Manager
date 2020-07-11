class AlterJoinTablePrimaryKey < ActiveRecord::Migration[5.2]
  def change
    def up
      remove_column :users_going_to_events, :id # remove existing primary key
      remove_column :users_going_to_events, :udid, :id # rename existing UDID column
      execute "ALTER TABLE users_going_to_events ADD PRIMARY KEY (user_id, event_id);"
    end
  
    def down
      # Remove the UDID primary key. Note this would differ based on your database
      execute "ALTER TABLE users_going_to_events DROP CONSTRAINT table_pkey;"
      addx_column :users_going_to_events, :id, :udid
      add_column :users_going_to_events, :id, :primary_key
    end
  end
end
