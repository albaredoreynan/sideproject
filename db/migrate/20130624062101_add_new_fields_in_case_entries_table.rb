class AddNewFieldsInCaseEntriesTable < ActiveRecord::Migration
  def change
  	add_column :case_entries, :create_multiple_lawyer_entries, :bool
  end
end
