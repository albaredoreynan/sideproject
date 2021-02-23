class RemoveColumnFromFilematters < ActiveRecord::Migration
  def change
  	remove_column :practice_tables, :practice_table_id
  	add_column :file_matters, :practice_table_id, :integer
  end
end
