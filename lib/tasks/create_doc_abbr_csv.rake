require 'csv'
task :create_doc_abbr_csv => :environment do
  csv_text = File.read('doc_abbr.csv')
  csv = CSV.parse(csv_text, headers: true)
  puts "Initializing..\n"
  csv.each_with_index do |row,index|
    DocAbbreviation.create(
        :document_name => row["document_name"],
        :doc_abbreviation => row["doc_abbreviation"]
    )
  end
  puts "Done"
  puts "End of task"
end