class Lawyer < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :middle_name, :mobile_number, :position, :email, :rate, :initials
  has_many :assigned_lawyers, :dependent => :destroy 
  def full_name 
  	"#{first_name} #{middle_name} #{last_name}"
  end
  
end
