class AddWorkhourToUsers < ActiveRecord::Migration
  def change
    add_column :users, :workhour, :integer
  end
end
