class CreateMonth < ActiveRecord::Migration
  def change
    create_table :months do |t|
      t.string :name
      t.integer :user_id
      t.integer :year
      t.timestamps
    end
  end
end
