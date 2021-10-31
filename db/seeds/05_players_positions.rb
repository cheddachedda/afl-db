require 'httparty'
require 'nokogiri'
require 'pry'

# key = club name as it appears in dreamteamtalk.com
# value = :name as per our Club model
@dreamteamtalk_aliases = {
  :'Adelaide Crows' => 'Adelaide Crows',
  :'Brisbane Lions' => 'Brisbane Lions',
  :'Carlton' => 'Carlton Blues',
  :'Collingwood' => 'Collingwood Magpies',
  :'Essendon' => 'Essendon Bombers',
  :'Fremantle' => 'Fremantle Dockers',
  :'Geelong Cats' => 'Geelong Cats',
  :'Gold Coast Suns' => 'Gold Coast Suns',
  :'Greater Western Sydney' => 'Greater Western Sydney Giants',
  :'Hawthorn' => 'Hawthorn Hawks',
  :'Melbourne' => 'Melbourne Demons',
  :'North Melbourne' => 'North Melbourne Kangaroos',
  :'Port Adelaide' => 'Port Adelaide Power',
  :'Richmond' => 'Richmond Tigers',
  :'St Kilda' => 'St Kilda Saints',
  :'Sydney Swans' => 'Sydney Swans',
  :'West Coast Eagles' => 'West Coast Eagles',
  :'Western Bulldogs' => 'Western Bulldogs'
}

# Scrapes dtlive.com.au to get all player positions.
def scrape_fantasy_positions
  url = "https://dreamteamtalk.com/2020/12/12/2021-afl-fantasy-positions/"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page.body)

  rows = parsed_page.css('tbody').css('tr')
  players = []

  # Iterate through all rows (except 1 header row and 1 footer row)
  rows.each do |row|
    data = row.css('td').map{ |td| td.text }

    name = data[0]

    player = {
      name: name,
      first_name: name[..name.index(' ')-1],
      middle_initial: nil,
      last_name: name[name.index(' ')+1..],
      club: @dreamteamtalk_aliases[data[1].to_sym],
      position: data[2].split('/'),
    }

    if name.include? '.'
      player[:middle_initial] = name[name.index(' ')+1..name.index('.')]
      player[:last_name] = name[name.index('.')+2..]
    end

    players << player
  end

  players
end

@failed_players = []
@scrape_count = 0

puts "Scraping fantasy positions"

# Perform Scrape
scrape_fantasy_positions.each do |scraped_player|
  player = Player.find_by(
    first_name: scraped_player[:first_name],
    last_name: scraped_player[:last_name],
    club: Club.find_by( name: scraped_player[:club] )
  )

  if player
    Player.update player.id, :position => scraped_player[:position]
    puts "Added #{ player.position } to #{ player.name }"
    @scrape_count += 1
  else
    @failed_players << "#{ scraped_player[:name] }"
    puts "Failed to find a match for #{ scraped_player[:name] } #{ scraped_player[:position] }"
  end
end

puts "#{ @scrape_count }/#{ Player.count } players' positions added"
puts "Position scrape failed for: #{ @failed_players.join(', ') }"
