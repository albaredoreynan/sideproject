class AddNewFieldsUsersLawyers < ActiveRecord::Migration
  def change
  	add_column :lawyers, :is_active, :string, :default => "Yes"
  	add_column :users, :is_active, :string, :default => "Yes"
  end
end
