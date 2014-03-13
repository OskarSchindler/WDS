class AddLeaveToUsers < ActiveRecord::Migration
  def change
    add_column :users, :leave, :integer
  end
end
