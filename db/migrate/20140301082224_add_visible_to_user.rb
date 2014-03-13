class AddVisibleToUser < ActiveRecord::Migration
  def change
    add_column :users, :visible, :integer
  end
end
