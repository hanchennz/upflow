class AddRepeatByToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :repeat_by, :integer
  end
end
