class AddFieldsInFileMatters < ActiveRecord::Migration
  def change
  	add_column :file_matters, :amount, :decimal, precision: 15, scale: 2, null: false, default: 0
  end
end
