class AddUserIdFieldsInCaseEntries < ActiveRecord::Migration
  def change		
	add_column :case_entries, :user_id, :integer
  end
end
