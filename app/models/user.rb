class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  has_one :user
  belongs_to :lawyer
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessor :login
  attr_accessible :email, :password, :password_confirmation, :remember_me, :position, :name, :address, :birthdate, :contact_number, :mobile_number, :employee_id, :username, :role, :login

  # after_create :create_client_name
  
  # def create_lawyers
  #   if !registration.nil?
  # 	 create_client(:name => name, :position => )
  #   end
  # end

  #logging in using username or email
  def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions).first
      end
  end
  
end
