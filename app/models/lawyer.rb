class Lawyer < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :middle_name, :mobile_number, :position, :email, :rate, :initials, :dollar_rate, :is_active
  has_many :assigned_lawyers, :dependent => :destroy 
  has_one :user
  has_many :case_entries
  has_many :schedules
  def full_name 
  	"#{first_name} #{middle_name} #{last_name}"
  end
  
end
