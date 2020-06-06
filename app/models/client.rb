class Client < ActiveRecord::Base
  attr_accessible :name, :email, :contact_number, :position, :address, :contact_person
  belongs_to :file_matter
  belongs_to :case_entry
  belongs_to :schedule

  validates_uniqueness_of :name, :case_sensitive => true, :on => :create
end
