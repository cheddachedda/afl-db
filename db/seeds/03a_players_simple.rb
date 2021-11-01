require "httparty"
require "nokogiri"

# Scrapes all players from dtlive.com.au
def dtlive_scraper
  url = "http://dtlive.com.au/afl/dataview.php"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page.body)

  rows = parsed_page.css('tbody')[0].css('tr')

  # Iterate through all rows (except 1 header row and 1 footer row)
  rows.each do |row|
    href = row.css('a')[0].attr('href')
    name = dtlive_player_name_scraper(href)

    club_abbr = row.css('img').attr('src').value[7..9] # Gets the Club.abbreviation from the img.src
    data = row.css('td').map { |td| td.text }

    player = {
      :name => name,
      :club_id => Club.find_by(abbreviation: club_abbr).id,
      :position => data[2].upcase.split(','),
      :fantasy_scores => data[14..].map{ |n| n.empty? ? nil : n.to_i },
    }
    Player.create(player)
    puts player
  end
end

# Uses dtlive's player id to scrape the page at that path for the player's full name and DOB
def dtlive_player_name_scraper href
  player_path = "http://dtlive.com.au/afl/#{ href }"
  unparsed_player_page = HTTParty.get(player_path)
  parsed_player_page = Nokogiri::HTML(unparsed_player_page.body)

  # The <h3> contains the player's name, followed by current age inside <small> tags
  current_age = parsed_player_page.css('h3')[0].css('small').text
  name = parsed_player_page.css('h3')[0].text.split(current_age).join().strip
end

dtlive_scraper
