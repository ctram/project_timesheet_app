class CreateAllocation < ActiveRecord::Migration
  def change
    create_table :allocations do |t|
      t.string :project_code
      t.integer :percentage
      t.integer :day_id
      t.timestamps
    end
  end
end
