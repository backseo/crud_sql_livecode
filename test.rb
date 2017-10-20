require "sqlite3"

db_file_path = File.join(File.dirname(__FILE__), "tasks.db")
DB = SQLite3::Database.new(db_file_path)
DB.results_as_hash = true
# above lines must be kept

require_relative 'task'

# p Task.all

p Task.find(1)




# task = Task.find(1)
# puts task.title

# Task.all.each do |task|
#   puts "#{task.id}. [#{task.done ? 'X' : ' ' }] #{task.title}"
# end

# task = Task.find(2)
# task.destroy

# task = Task.find(3)
# task.done = true
# task.save
