class RemoveBorderColorFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :border_color
  end
end
