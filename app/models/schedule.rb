class Schedule < ActiveRecord::Base
  attr_accessible :client, :lawyer_id, :schedule_date, :schedule_time, 
                  :status, :purpose, :sched_title, :start_time, :end_time,
                  :client_id, :file_matter_id, :file_matter_case, :case_title,
                  :ref_no
  has_many :clients
  belongs_to :lawyer
end
