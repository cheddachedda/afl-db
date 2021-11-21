require 'httparty'
require 'nokogiri'

# key = club name as it appears in afltables.com
# value = :name as per our Club model
@aliases = {
  :'Adelaide' => 'Adelaide',
  :'Brisbane Lions' => 'Brisbane',
  :'Carlton' => 'Carlton',
  :'Collingwood' => 'Collingwood',
  :'Essendon' => 'Essendon',
  :'Fremantle' => 'Fremantle',
  :'Geelong' => 'Geelong',
  :'Gold Coast' => 'Gold Coast',
  :'Greater Western Sydney' => 'Greater Western Sydney',
  :'Hawthorn' => 'Hawthorn',
  :'Melbourne' => 'Melbourne',
  :'North Melbourne' => 'North Melbourne',
  :'Port Adelaide' => 'Port Adelaide',
  :'Richmond' => 'Richmond',
  :'St Kilda' => 'St Kilda',
  :'Sydney' => 'Sydney',
  :'West Coast' => 'West Coast',
  :'Western Bulldogs' => 'Western Bulldogs'
}

def scrape_players
  url = "https://afltables.com/afl/stats/2021.html"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page.body)

  club_tables = parsed_page.css('.sortable')
  club_tables.each do |club_table|
    # Extracts the club name from the first <a> in the table
    # Converts the afltables.com club name to its matching name in our db
    club_name = @aliases[club_table.css('a').first.text.to_sym]
    club = Club.find_by_name club_name

    club_table.css('tbody')[0].css('tr').each do |player_row|
      data = player_row.css('td').map{ |td| td.text } # Returns an array of each <td>'s text

      # Creates model
      new_player = Player.create(
        :first_name => data[1].split(', ').last,
        :last_name => data[1].split(', ').first,
        :club => club,
        :jersey => data[0].to_i
      )

      puts "Created Player: #{ new_player[:first_name] } #{ new_player[:last_name]}"
    end
  end
end

puts "Scraping basic player info"
scrape_players
puts "#{ Player.count } players created"
