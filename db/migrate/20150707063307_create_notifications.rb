class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
    	t.integer :user_id
    	t.string  :notification_title
    	t.text    :details
    	t.date    :start_date
    	t.date    :end_date
      t.timestamps
    end
  end
end