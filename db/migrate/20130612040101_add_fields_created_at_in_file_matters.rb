class AddFieldsCreatedAtInFileMatters < ActiveRecord::Migration
  def change
  	add_column :file_matters, :created_at, :timestamp
    add_column :file_matters, :updated_at, :timestamp
  end
end
