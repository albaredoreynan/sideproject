class RemoveCreatedAtInFileMatters < ActiveRecord::Migration
  def change
  	remove_column :file_matters, :created_at
  	remove_column :file_matters, :updated_at
  end
end
