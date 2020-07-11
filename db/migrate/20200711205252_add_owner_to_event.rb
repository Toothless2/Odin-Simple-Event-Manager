class AddOwnerToEvent < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :owner, foreign_key: true
  end
  
  add_index :events, :owner
end
