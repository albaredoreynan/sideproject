class Lawyer < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :middle_name, :mobile_number, :position, :email
end
