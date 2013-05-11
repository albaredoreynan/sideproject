class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :position, :name, :address, :birthdate, :contact_number, :mobile_number, :employee_id, :username

  # after_create :create_client_name
  
  # def create_lawyers
  #   if !registration.nil?
  # 	 create_client(:name => name, :position => )
  #   end
  # end
end
