class AddFieldsToTableCaseEntries < ActiveRecord::Migration
  def change
  	add_column :case_entries, :file_matter_case, :string
  	add_column :case_entries, :lawyer_id, :integer
  end
end
