class AddFieldsForTableCaseEntries < ActiveRecord::Migration
  def change
  	add_column :case_entries, :case_title, :string
  end
end
