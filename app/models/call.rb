class Call < ActiveRecord::Base
  attr_accessible :called_number, :number_of_minutes, :call_amounts, :client, :call_date, :client_id
end
