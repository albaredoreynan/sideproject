class FileMatter < ActiveRecord::Base
  attr_accessible :year, :file_code, :volume, :client_id, :title, :case_number, :case_date, :assigned_lawyers_attributes, :currency_used, :case_pricing, :fixed_rate,
                  :cl_code_num, :cl_code_txt, :practice_table_id, :practice_code
  belongs_to :client
  belongs_to :practice_table
  has_many :assigned_lawyers, :dependent => :destroy
  accepts_nested_attributes_for :assigned_lawyers, :reject_if => :all_blank, :allow_destroy => true
end
