class AddFieldsInCaseEntries < ActiveRecord::Migration
  def change
  	add_column :case_entries, :practice_code, :string
  	add_column :case_entries, :client_code, :string
  end
end
