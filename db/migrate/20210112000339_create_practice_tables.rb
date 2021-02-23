class CreatePracticeTables < ActiveRecord::Migration
  def change
    create_table :practice_tables do |t|
    	t.integer     :code_id
    	t.string      :practice_name
    	t.string      :text_code
    	t.timestamps
    end
  end
end
