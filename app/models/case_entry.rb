class CaseEntry < ActiveRecord::Base
  attr_accessible :client_id, :entry_date, :file_matter_id, :file_matter_case, :lawyer_id, :time_spent_from, :time_spent_to, :work_particulars, :case_title, :user_id, :create_multiple_lawyer_entries, :client_name
  has_many :clients
  has_many :file_matters
end
