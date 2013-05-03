class FileMatter < ActiveRecord::Base
  attr_accessible :year, :file_code, :volume, :client_id, :title, :case_number, :lawyer_id, :case_date
  has_many :clients
  has_many :lawyers
end
