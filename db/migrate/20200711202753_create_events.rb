class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.datetime :when

      t.timestamps
    end
    add_index :events, :title
    add_index :events, :when
  end
end
