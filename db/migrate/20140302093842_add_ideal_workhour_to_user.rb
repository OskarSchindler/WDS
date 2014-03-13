class AddIdealWorkhourToUser < ActiveRecord::Migration
  def change
    add_column :users, :ideal_workhour, :integer
  end
end
