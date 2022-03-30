class CaseEntry < ActiveRecord::Base
  attr_accessible :client_id, :entry_date, :file_matter_id, 
  								:file_matter_case, :lawyer_id, :time_spent_from, 
  								:time_spent_to, :work_particulars, :case_title, 
  								:user_id, :create_multiple_lawyer_entries, 
  								:client_name, :remove_from_billing,
  								:client_code, :practice_code, :mark_as_billed

  has_many :clients
  has_many :file_matters
  belongs_to :lawyer
  accepts_nested_attributes_for :lawyer
  #validates_presence_of :entry_date, :message => 'Date should not be blank'
end
