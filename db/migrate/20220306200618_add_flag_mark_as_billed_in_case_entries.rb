class AddFlagMarkAsBilledInCaseEntries < ActiveRecord::Migration
  def change
    add_column :case_entries, :mark_as_billed, :string, :default => false
  end
end
