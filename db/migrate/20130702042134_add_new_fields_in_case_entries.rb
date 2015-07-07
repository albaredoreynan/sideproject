class AddNewFieldsInCaseEntries < ActiveRecord::Migration
  def change
  	add_column :case_entries, :client_name, :string
  end
end
