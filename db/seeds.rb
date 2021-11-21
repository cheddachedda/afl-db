Club.destroy_all
Fixture.destroy_all
Player.destroy_all
GameLog.destroy_all

start_time = Time.new

# Runs all seed files in db/seeds/ in alphabetical order of filenames
Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each { |seed| load seed }

end_time = Time.new
run_time = (end_time - start_time).round
puts "Seeded in #{ run_time } seconds"

# rails db:drop
# rails db:create
# rails db:migrate
# rails db:seed
