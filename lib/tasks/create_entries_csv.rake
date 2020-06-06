require 'csv'
task :create_entries_csv => :environment do
  csv_text = File.read('PeterBantilan-timesheet.csv')
  user_id = 8
  lawyer_id = 8
  csv = CSV.parse(csv_text, headers: true)
  puts "Initializing..\n"
  csv.each_with_index do |row,index|
  @file_code = row["File Reference No:"]
  @file_matter = FileMatter.find_by_file_code(@file_code.to_str)
  if @file_matter.nil?
    puts @file_code
    puts "File Matter Code doesn't exist."
  else
    CaseEntry.create(
        :file_matter_id => @file_matter.file_code,
        :entry_date => row["Date (YYYY-MM-DD)"],
        :time_spent_from => row["Start Time"],
        :time_spent_to => row["End Time"],
        :work_particulars => row["Work Particulars"],
        :client_id => @file_matter.client_id,
        :case_title => @file_matter.title,
        :file_matter_case => @file_matter.case_number,
        :lawyer_id => lawyer_id,
        :user_id => user_id
    )
  end
  puts "Done"
  end
  puts "End of task"
end



