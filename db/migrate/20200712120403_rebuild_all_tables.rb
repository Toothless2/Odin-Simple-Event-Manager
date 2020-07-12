class RebuildAllTables < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name

      t.timestamps
    end
    add_index :users, :email

    create_table :events do |t|
      t.string :title
      t.string :description
      t.datetime :when
      t.references :users, :owner, foreign_key: true

      t.timestamps
    end
    add_index :events, :title
    add_index :events, :when
    add_index :events, :owner


    create_table :users_going_to_events do |t|
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true

      t.timestamps
    end

    add_index :users_going_to_events, [:user, :events]
  end
end
