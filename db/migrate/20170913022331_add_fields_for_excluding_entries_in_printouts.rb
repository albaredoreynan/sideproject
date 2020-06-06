class AddFieldsForExcludingEntriesInPrintouts < ActiveRecord::Migration
  def change
  	add_column :printouts, :entry_flag, :bool, :default => true
  end
end
