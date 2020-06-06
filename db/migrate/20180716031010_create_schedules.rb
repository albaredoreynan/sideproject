class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
    	t.integer     :client_id
    	t.integer     :lawyer_id
    	t.datetime    :schedule_date
    	t.text        :purpose
    	t.string      :status
    	t.string 			:schedule_time
      t.timestamps
    end
  end
end