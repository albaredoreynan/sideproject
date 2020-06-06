class AddFieldsInSchedules < ActiveRecord::Migration
  def change
  	add_column :schedules, :start_time, :datetime
  	add_column :schedules, :end_time, :datetime
  	add_column :schedules, :sched_title, :string
  end
end
