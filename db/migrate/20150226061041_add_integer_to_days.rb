class AddIntegerToDays < ActiveRecord::Migration
  def change
    add_column :days, :number, :integer
  end
end
