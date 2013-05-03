class CreateFileMatters < ActiveRecord::Migration
  def change
    create_table :file_matters do |t|
	  t.string :year
      t.string :file_code
      t.string :volume
      t.string :client_id
      t.string :title
      t.string :case_number
      t.string :lawyer_id
      t.string :case_date
      t.timestamps
    end
  end
end
