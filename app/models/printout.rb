class Printout < ActiveRecord::Base
  attr_accessible :ref_no, :entry_date, :case_title, :client, :document_name, :num_page, :num_copy, :paper_size, :client_id,
  								:file_matter_id, :file_matter_case, :lawyer_id, :times_amount
end
