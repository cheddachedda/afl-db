require 'httparty'
require 'nokogiri'

@failed_players = []

# Scrape for a specific player's complete game-by-game stats from afltables.com
def scrape_player_stats player, url = ''
  first_name = player.first_name
  last_name = player.last_name

  if url.empty?
    url = "https://afltables.com/afl/stats/players/#{ first_name[0] }/#{ first_name }_#{ last_name.gsub(' ', '_') }.html"
  end

  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page.body)

  unless parsed_page.css('.sortable').empty?
    # .last returns the table for the current or most recent season
    season_table = parsed_page.css('.sortable').last

    # Each <tr> contains stats an individual fixture
    fixture_rows = season_table.css('tbody')[0].css('tr')

    # Iterates through each fixture
    fixture_rows.each do |row|
      data = row.css('td').map do |td|
        if td.text.chars.any? { |char| ('a'..'z').include? char.downcase }
          td.text
        else
          td.text.to_i
        end
      end

      # Converts finals round string into round_no integer
      round_no = case data[2]
      when 'QF'
        24
      when 'EF'
        24
      when 'SF'
        25
      when 'PF'
        26
      when 'GF'
        27
      else
        data[2]
      end

      new_game_log = GameLog.create(
        :player => player,
        :fixture => player.club.fixtures.find_by(round_no: round_no),
        :club => player.club,
        :kicks => data[5],
        :marks => data[6],
        :handballs => data[7],
        :goals => data[9],
        :behinds => data[10],
        :hit_outs => data[11],
        :tackles => data[12],
        :free_kicks_for => data[17],
        :free_kicks_against => data[18],
        :percentage_time_on_ground => data[27]
      )
      puts "Created GameLog: #{ new_game_log.id } #{ player.first_name } #{ player.last_name } R#{ round_no }"
    end
  else  # if the url cannot be found
    @failed_players << player
    puts "Failed to create game logs for #{ player.id } #{ first_name } #{ last_name }"
  end
end

puts "Scraping player stats"
Player.all.each do |player|
  scrape_player_stats player
end
puts "Created #{ GameLog.count } game logs"
puts "#{ Player.count - @failed_players.count }/#{ Player.count } players' stats scraped"
puts "Stats scrape failed for: #{ @failed_players.map{|p| [p.id, p.first_name, p.last_name].join(' ')}.join(', ') }"
