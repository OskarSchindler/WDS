class AddTriggerToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :trigger, :integer
  end
end
