class Notification < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :user_id, :notification_title, :details, :start_date, :end_date, :notified
  has_many :users
end