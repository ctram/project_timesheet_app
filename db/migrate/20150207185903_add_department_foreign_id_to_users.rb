class AddDepartmentForeignIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :department_id, :integer
    remove_column :users, :department
  end
end
