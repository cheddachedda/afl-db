require 'httparty'
require 'nokogiri'
require 'pry'

# key = club name as it appears in afltables.com
# value = :name as per our Club model
@afl_tables_aliases = {
  :'Adelaide' => 'Adelaide Crows',
  :'Brisbane Lions' => 'Brisbane Lions',
  :'Carlton' => 'Carlton Blues',
  :'Collingwood' => 'Collingwood Magpies',
  :'Essendon' => 'Essendon Bombers',
  :'Fremantle' => 'Fremantle Dockers',
  :'Geelong' => 'Geelong Cats',
  :'Gold Coast' => 'Gold Coast Suns',
  :'Greater Western Sydney' => 'Greater Western Sydney Giants',
  :'Hawthorn' => 'Hawthorn Hawks',
  :'Melbourne' => 'Melbourne Demons',
  :'North Melbourne' => 'North Melbourne Kangaroos',
  :'Port Adelaide' => 'Port Adelaide Power',
  :'Richmond' => 'Richmond Tigers',
  :'St Kilda' => 'St Kilda Saints',
  :'Sydney' => 'Sydney Swans',
  :'West Coast' => 'West Coast Eagles',
  :'Western Bulldogs' => 'Western Bulldogs'
}

def scrape_players
  url = "https://afltables.com/afl/stats/2021.html"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page.body)

  tables = parsed_page.css('.sortable')
  tables.each do |table|
    table.css('tbody')[0].css('tr').each do |tr|

      # Converts an afltables.com club name to its matching Club.name
      parsed_club_name = @afl_tables_aliases[table.css('a').first.text.to_sym]

      # Creates model
      new_player = Player.create(
        :first_name => tr.children[1].text.split(', ')[1],
        :last_name => tr.children[1].text.split(', ')[0],
        :club_id => Club.find_by( name: parsed_club_name ).id,
        :jersey => tr.children[0].text.to_i,
      )

      puts "#{ new_player[:first_name] } #{ new_player[:last_name]} created"
    end
  end
end

puts "Scraping basic player info"
scrape_players
puts "#{ Player.count } players created"
