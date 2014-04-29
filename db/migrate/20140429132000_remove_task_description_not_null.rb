class RemoveTaskDescriptionNotNull < ActiveRecord::Migration
  def change
    change_column_null :tasks, :description, true
  end
end
