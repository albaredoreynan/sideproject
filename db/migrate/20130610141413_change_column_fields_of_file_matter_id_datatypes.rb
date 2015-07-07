class ChangeColumnFieldsOfFileMatterIdDatatypes < ActiveRecord::Migration
  def change		
	change_column :case_entries, :file_matter_id, :string
  end
end
