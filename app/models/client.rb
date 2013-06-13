class Client < ActiveRecord::Base
  attr_accessible :name, :email, :contact_number, :position, :address, :contact_person
  belongs_to :file_matter
  belongs_to :case_entry
end
