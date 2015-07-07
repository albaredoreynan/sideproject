class CreateCaseEntries < ActiveRecord::Migration
  def change
    create_table :case_entries do |t|
      t.date :entry_date
      t.text :work_particulars
      t.integer :client_id
      t.integer :file_matter_id
      t.string :time_spent_from
      t.string :time_spent_to	
      t.timestamps
    end
  end
end
