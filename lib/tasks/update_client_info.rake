require 'csv'
task :update_client_info => :environment do
  csv_text = File.read('client_ind.csv')
  csv = CSV.parse(csv_text, headers: true)
  puts "Initializing..\n"
  csv.each_with_index do |row,index|
    clname = row["NAME"]
    @client = Client.where("name ILIKE ?", clname)
    
    if @client.first.nil?
    #   puts row["full_name"]
    #   puts "User not found."
      puts clname
      puts "Not Found"

    else
      puts @client.first.name
      @client.first.cl_code_txt = row["CODE"]
      @client.first.save
      puts "Client Updated"
    #   @client.username = row["username"]
    #   @client.password = row["password"]
    #   @client.save
    #   puts "User updated"
    end
    puts "Done"
  end
  puts "End of task"
end
