class RemoveColumnFromClients < ActiveRecord::Migration
  def change
  	remove_column :clients, :cl_code_num
  	add_column :clients, :cl_code_num, :string
  end
end
