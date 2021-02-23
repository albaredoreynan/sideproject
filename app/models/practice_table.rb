class PracticeTable < ActiveRecord::Base
  attr_accessible :code_id, :practice_name, :text_code
  has_many :file_matters
end
