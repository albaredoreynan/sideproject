class CreateCalls < ActiveRecord::Migration
  def change
    create_table :calls do |t|
    	t.string :called_number
    	t.integer :number_of_minutes
      t.integer :call_amounts
      t.string :client
      t.date :call_date
      t.timestamps
    end
  end
end
