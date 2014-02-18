class AddDeletedAtIndexToTasks < ActiveRecord::Migration
  def change
    add_index :tasks, :deleted_at
  end
end
