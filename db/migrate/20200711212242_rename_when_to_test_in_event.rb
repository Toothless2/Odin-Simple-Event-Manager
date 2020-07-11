class RenameWhenToTestInEvent < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :when, :test
  end
end
