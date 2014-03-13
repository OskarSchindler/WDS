class AddLeaveCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :leave_count, :integer
  end
end
