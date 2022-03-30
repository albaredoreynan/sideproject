class CreateCaseEntryBillings < ActiveRecord::Migration
  def change
    create_table :case_entry_billings do |t|
      t.string      :or_number
      t.string      :invoice_number
      t.string      :file_reference_code
      t.integer     :file_matter_id
      t.integer     :client_id
      t.datetime    :cover_period_start
      t.datetime    :cover_period_end
      t.datetime    :billing_date
      t.string      :biliing_status
      t.string      :submitted_to_lawyers
      t.string      :submitted_to_bill_admin
      t.timestamps
    end
  end
end
