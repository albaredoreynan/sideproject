class CreateNewTableForLawyersAndFileMatterId < ActiveRecord::Migration
  def change
    create_table :assigned_lawyers do |t|
      t.integer :lawyer_id
      t.integer :file_matter_id
      t.integer :client_id	
      t.timestamps
    end
  end
end
