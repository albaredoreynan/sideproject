class AddNewFieldsInLawyers < ActiveRecord::Migration
  def change		
	add_column :clients, :contact_person, :string
	add_column :lawyers, :rate, :string
	add_column :lawyers, :initials, :string
  end
end
