class CaseEntryBilling < ActiveRecord::Base
  attr_accessible :or_number, :invoice_number, :file_reference_code, 
                  :file_matter_id, :client_id, :cover_period_start, 
                  :cover_period_end, :billing_date, :biliing_status, 
                  :submitted_to_lawyers, :submitted_to_bill_admin
  has_many :clients
  has_many :file_matters
end


