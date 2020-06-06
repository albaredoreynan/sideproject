class AddRefNoInSchedules < ActiveRecord::Migration
  def change
  	add_column :schedules, :ref_no, :integer
  end
end
