class AddNewFieldsInClients < ActiveRecord::Migration
  def change
  	add_column :clients, :position, :string
  	add_column :clients, :address, :text
  end
end
