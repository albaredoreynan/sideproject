class AssignedLawyer < ActiveRecord::Base
  attr_accessible :file_matter_id, :client_id, :lawyer_id, :amount, :file_matter_pricing
  belongs_to :lawyer
  belongs_to :file_matters
end
