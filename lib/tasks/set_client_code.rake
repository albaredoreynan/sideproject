task :set_client_code => :environment do
  client_ids = Client.where("cl_code_txt IS NOT NULL").pluck(:id)
  
  client_ids.each do |clid|
    cl = Client.find(clid)
    puts clid
    puts cl.cl_code_txt
    @case_entries = CaseEntry.where(:client_id => clid)
    
    @case_entries.update_all(:client_code => cl.cl_code_txt)
    puts "updated"
  end

  # case_entries = CaseEntry.find(client_id)
  # csv_text = File.read('PeterBantilan-timesheet.csv')
  # user_id = 8
  # lawyer_id = 8
  # csv = CSV.parse(csv_text, headers: true)
  # puts "Initializing..\n"
  # csv.each_with_index do |row,index|
  # @file_code = row["File Reference No:"]
  # @file_matter = FileMatter.find_by_file_code(@file_code.to_str)
  # if @file_matter.nil?
  #   puts @file_code
  #   puts "File Matter Code doesn't exist."
  # else
  #   CaseEntry.create(
  #       :file_matter_id => @file_matter.file_code,
  #       :entry_date => row["Date (YYYY-MM-DD)"],
  #       :time_spent_from => row["Start Time"],
  #       :time_spent_to => row["End Time"],
  #       :work_particulars => row["Work Particulars"],
  #       :client_id => @file_matter.client_id,
  #       :case_title => @file_matter.title,
  #       :file_matter_case => @file_matter.case_number,
  #       :lawyer_id => lawyer_id,
  #       :user_id => user_id
  #   )
  # end
  # puts "Done"
  # end
  # puts "End of task"
end



