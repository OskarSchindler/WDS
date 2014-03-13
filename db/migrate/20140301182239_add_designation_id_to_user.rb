class AddDesignationIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :designation_id, :integer
  end
end
