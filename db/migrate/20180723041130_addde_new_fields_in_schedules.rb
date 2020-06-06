class AdddeNewFieldsInSchedules < ActiveRecord::Migration
  def change
  	add_column :schedules, :time_schedule, :datetime
  end
end
