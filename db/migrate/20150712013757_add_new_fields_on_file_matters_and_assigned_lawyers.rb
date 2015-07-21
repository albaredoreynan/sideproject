class AddNewFieldsOnFileMattersAndAssignedLawyers < ActiveRecord::Migration
  def change
  	add_column :assigned_lawyers, :file_matter_pricing, :decimal, precision: 15, scale: 2, null: false, default: 0
  	add_column :file_matters, :case_pricing, :decimal, precision: 15, scale: 2, null: false, default: 0
  end
end
