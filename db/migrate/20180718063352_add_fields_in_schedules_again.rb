class AddFieldsInSchedulesAgain < ActiveRecord::Migration
  def change
  	remove_column :schedules, :client_id
  	add_column  :schedules, :client, :string
  end
end
