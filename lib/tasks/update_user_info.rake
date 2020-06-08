require 'csv'
task :update_user_info => :environment do
  csv_text = File.read('user_info.csv')
  csv = CSV.parse(csv_text, headers: true)
  puts "Initializing..\n"
  csv.each_with_index do |row,index|
  user_id = row["user_id"]
  
  @user = User.find(user_id)
  if @user.nil?
    puts row["full_name"]
    puts "User not found."
  else
    @user.username = row["username"]
    @user.password = row["password"]
    @user.save
    puts "User updated"
  end
  puts "Done"
  end
  puts "End of task"
end
