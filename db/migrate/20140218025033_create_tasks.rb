class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.belongs_to :user, index: true, null: false
      t.datetime :completed_at
      t.datetime :deleted_at
      t.datetime :due_at
      t.string :border_color, null: false
      t.string :color, null: false
      t.string :name, null: false
      t.string :type, null: false
      t.text :description, null: false
      t.timestamps null: false
    end
  end
end
