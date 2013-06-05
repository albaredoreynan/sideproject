class FileMatter < ActiveRecord::Base
  attr_accessible :year, :file_code, :volume, :client_id, :title, :case_number, :case_date, :assigned_lawyers_attributes
  has_many :clients
  has_many :assigned_lawyers, :dependent => :destroy
  accepts_nested_attributes_for :assigned_lawyers
end
