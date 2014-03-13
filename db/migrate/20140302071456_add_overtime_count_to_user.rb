class AddOvertimeCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :overtime_count, :integer
  end
end
