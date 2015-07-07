class AdminSide < ActiveRecord::Base
  
  scope :beginning_date, lambda {|s_date| where('entry_date >= ?', s_date) unless date.blank? }
  scope :ending_date, lambda {|e_date| where('entry_date <= ?', e_date) unless date.blank? }
  scope :search_lawyer_id, lambda {|l_id| where(:lawyer_id => l_id) unless id.blank? }
  scope :search_client_id, lambda {|c_id| where(:client_id => c_id) unless id.blank? }

  def self.search_by_date(starting, ending)
    finder = beginning_date(starting)
    finder = finder.ending_date(ending)
    return finder
  end

  def self.search_queries(queries)
  	finder = search_client_id.(queries[:client_id])
    finder = finder.search_by_date(queries[:beginning_date], queries[:ending_date])
    finder = finder.search_lawyer_id(queries[:lawyer_id])
    return finder
  end

end
