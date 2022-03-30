class Client < ActiveRecord::Base
  attr_accessible :name, :email, :contact_number, :position, :address, :contact_person,
                  :cl_code_num, :cl_code_txt
  has_many :file_matters
  belongs_to :case_entry
  belongs_to :case_entry_billing
  belongs_to :schedule

  validates_uniqueness_of :name, :case_sensitive => true, :on => :create
end
