class AssignedLawyer < ActiveRecord::Base
  attr_accessible :file_matter_id, :client_id, :lawyer_id
  belongs_to :lawyer
  belongs_to :file_matters
end
