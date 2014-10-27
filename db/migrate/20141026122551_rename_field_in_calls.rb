class RenameFieldInCalls < ActiveRecord::Migration
  def change
  	add_column :calls, :client_id, :integer
  	add_column :printouts, :client_id, :integer
  	add_column :printouts, :file_matter_id, :integer
  	add_column :printouts, :file_matter_case, :string
  	add_column :printouts, :lawyer_id, :integer
  	add_column :printouts, :times_amount, :decimal, precision: 15, scale: 2, null: false, default: 0
  end
end
