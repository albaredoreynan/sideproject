class CreatePrintouts < ActiveRecord::Migration
  def change
    create_table :printouts do |t|
    	t.integer :ref_no
    	t.date :entry_date
      t.string :case_title
      t.string :client
      t.string :document_name
      t.integer :num_page
      t.integer :num_copy
      t.string :paper_size
      t.timestamps
    end
  end
end