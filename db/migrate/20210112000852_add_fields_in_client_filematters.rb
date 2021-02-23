class AddFieldsInClientFilematters < ActiveRecord::Migration
  def change
  	add_column :clients, :cl_code_num, :integer
  	add_column :clients, :cl_code_txt, :string
    
    add_column :file_matters, :cl_code_num, :integer
    add_column :file_matters, :cl_code_txt, :string
    add_column :practice_tables, :practice_table_id, :integer 
  end
end
