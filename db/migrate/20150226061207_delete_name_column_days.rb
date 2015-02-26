class DeleteNameColumnDays < ActiveRecord::Migration
  def change
    remove_column :days,:name
  end
end
