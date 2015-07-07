class AddNewFieldsInFileMattersCurrencyUsed < ActiveRecord::Migration
  def change
  	add_column :file_matters, :currency_used, :string, :null => false, :default => "Peso"
  end
end
