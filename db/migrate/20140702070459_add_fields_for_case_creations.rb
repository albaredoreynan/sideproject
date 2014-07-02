class AddFieldsForCaseCreations < ActiveRecord::Migration
  def change
  	add_column :case_entries, :remove_from_billing, :string, :default => "No"
  end
end
