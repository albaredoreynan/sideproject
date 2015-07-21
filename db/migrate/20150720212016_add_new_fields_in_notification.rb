class AddNewFieldsInNotification < ActiveRecord::Migration
  def change
  	add_column :file_matters, :fixed_rate, :bool
  	add_column :notifications, :notified, :bool
  end
end
