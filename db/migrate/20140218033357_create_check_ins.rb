class CreateCheckIns < ActiveRecord::Migration
  def change
    create_table :check_ins do |t|
      t.belongs_to :task, index: true, null: false
      t.belongs_to :user, index: true, null: false
      t.datetime :deleted_at, index: true
      t.text :note, null: false
      t.timestamps null: false
    end
  end
end
