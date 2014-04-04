class RemoveUserFromCheckIn < ActiveRecord::Migration
  def change
    remove_column :check_ins, :user_id
  end
end
