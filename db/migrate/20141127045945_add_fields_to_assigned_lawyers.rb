class AddFieldsToAssignedLawyers < ActiveRecord::Migration
  def change
  	add_column :assigned_lawyers, :amount, :decimal, precision: 15, scale: 2, null: false, default: 0
  end
end
