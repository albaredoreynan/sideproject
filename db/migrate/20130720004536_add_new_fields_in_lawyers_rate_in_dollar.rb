class AddNewFieldsInLawyersRateInDollar < ActiveRecord::Migration
  def change
  	add_column :lawyers, :dollar_rate, :string
  end
end
