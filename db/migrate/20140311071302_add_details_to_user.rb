class AddDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :paid_leave_count, :integer
    add_column :users, :overtime_allocation, :integer
  end
end
