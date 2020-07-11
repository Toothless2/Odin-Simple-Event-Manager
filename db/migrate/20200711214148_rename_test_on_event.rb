class RenameTestOnEvent < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :test, :when
  end
end
