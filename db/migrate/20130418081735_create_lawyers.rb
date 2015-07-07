class CreateLawyers < ActiveRecord::Migration
  def change
    create_table :lawyers do |t|
      t.string :first_name
  	  t.string :last_name
  	  t.string :middle_name
  	  t.string :mobile_number
  	  t.string :position
  	  t.string :email
      t.timestamps
    end
  end
end
