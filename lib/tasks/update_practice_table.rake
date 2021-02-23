require 'csv'
task :update_practice_table => :environment do
  csv_text = File.read('practice_codes.csv')
  csv = CSV.parse(csv_text, headers: true)
  puts "Initializing..\n"
  csv.each_with_index do |row,index|
    pc_id = row["Num"]
    puts pc_id
    if pc_id == '1' || pc_id == '2' || pc_id == '4' || pc_id == '5' || pc_id == '6'
      @practice = PracticeTable.find(pc_id.to_i)
      @practice.code_id = ""
      @practice.practice_name = row["Practice"]
      @practice.text_code = row["Alpha Codes"]
      @practice.save
      puts "Entry Updated"
    else
      PracticeTable.create(
        :code_id => "",
        :practice_name => row["Practice"],
        :text_code => row["Alpha Codes"]
      )
      
      puts "Entry Created"
    end

    puts "Done"
  end
  puts "End of task"
end

# :code_id, :practice_name, :text_code