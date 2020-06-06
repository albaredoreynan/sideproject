class AddFileMatterInfoInSchedules < ActiveRecord::Migration
  def change
  	add_column 		:schedules, :client_id, :integer
  	add_column		:schedules, :file_matter_id, :string
  	add_column    :schedules, :file_matter_case, :string
  	add_column    :schedules, :case_title, :text
  end
end
