class Client < ActiveRecord::Base
  attr_accessible :name, :email, :contact_number
  # belongs_to :file_matter
  # belongs_to :case_entry
end
