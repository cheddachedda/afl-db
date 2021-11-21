require 'httparty'
require 'nokogiri'

# key = club name as it appears in dreamteamtalk.com
# value = :name as per our Club model
@aliases = {
  :'Adelaide Crows' => 'Adelaide',
  :'Brisbane Lions' => 'Brisbane',
  :'Carlton' => 'Carlton',
  :'Collingwood' => 'Collingwood',
  :'Essendon' => 'Essendon',
  :'Fremantle' => 'Fremantle',
  :'Geelong Cats' => 'Geelong',
  :'Gold Coast Suns' => 'Gold Coast',
  :'Greater Western Sydney' => 'Greater Western Sydney',
  :'Hawthorn' => 'Hawthorn',
  :'Melbourne' => 'Melbourne',
  :'North Melbourne' => 'North Melbourne',
  :'Port Adelaide' => 'Port Adelaide',
  :'Richmond' => 'Richmond',
  :'St Kilda' => 'St Kilda',
  :'Sydney Swans' => 'Sydney',
  :'West Coast Eagles' => 'West Coast',
  :'Western Bulldogs' => 'Western Bulldogs'
}

def scrape_players
  url = "https://dreamteamtalk.com/2020/12/12/2021-afl-fantasy-positions/"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page.body)

  rows = parsed_page.css('tbody').css('tr')

  # Iterate through all rows (except 1 header row and 1 footer row)
  rows.each do |row|
    data = row.css('td').map{ |td| td.text }

    name = data[0]
    first_name = data[0].split(' ').first
    middle_initial = nil
    last_name = data[0].split(' ').drop(1).join(' ')

    if name.include? '.'
      middle_initial = last_name.split('. ').first
      last_name = last_name.split('. ').drop(1).join(' ')
    end

    new_player = Player.create(
      :first_name => first_name,
      :middle_initial => middle_initial,
      :last_name => last_name,
      :club => Club.find_by_name( @aliases[ data[1].to_sym ] ),
      :position => data[2].split('/')
    )

    puts "Created Player: #{ new_player.id } #{ new_player.first_name } #{ new_player.last_name }"
  end
end

puts "Scraping players"
scrape_players
puts "#{ Player.count } players created"
