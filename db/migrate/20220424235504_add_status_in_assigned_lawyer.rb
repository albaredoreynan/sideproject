class AddStatusInAssignedLawyer < ActiveRecord::Migration
  def change
    add_column :assigned_lawyers, :status, :string, :default => 'Active'
  end
end
