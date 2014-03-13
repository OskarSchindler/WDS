class CreateOvertimes < ActiveRecord::Migration
  def change
    create_table :overtimes do |t|
      t.integer :ot

      t.timestamps
    end
  end
end
