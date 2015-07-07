class AddNewFieldsInUsersTable < ActiveRecord::Migration
  def change
  	add_column :users, :lawyer_id, :integer
  end
end
