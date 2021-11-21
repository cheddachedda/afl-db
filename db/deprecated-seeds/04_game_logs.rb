require 'httparty'
require 'nokogiri'
require 'pry'

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
    # Each <tr> contains stats an individual fixture
    # `rows` will contain an array of each <tr> to iterate through
    rows = parsed_page.css('.sortable').last.css('tbody')[0].css('tr')

    # Initialises player hash with blank arrays, so that each round's stats can be entered at a specific index.
    # This allows for DNPs and byes to be added as nils.
    player_stats = {
      :kicks => [],
      :marks => [],
      :handballs => [],
      :goals => [],
      :behinds => [],
      :hit_outs => [],
      :tackles => [],
      :free_kicks_for => [],
      :free_kicks_against => [],
      :percentage_time_on_ground => []
    }

    # Add each stat
    rows.each do |row|
      data = row.css('td')

      # Determines which index these stats will be added at
      # i = round number - 1
      i = case data[2].text
      when 'EF'
        23
      when 'SF'
        24
      when 'PF'
        25
      when 'GF'
        26
      else
        data[2].text.to_i - 1
      end

      player_stats[:kicks][i] = data[5].text.to_i
      player_stats[:marks][i] = data[6].text.to_i
      player_stats[:handballs][i] = data[7].text.to_i
      player_stats[:goals][i] = data[9].text.to_i
      player_stats[:behinds][i] = data[10].text.to_i
      player_stats[:hit_outs][i] = data[11].text.to_i
      player_stats[:tackles][i] = data[12].text.to_i
      player_stats[:free_kicks_for][i] = data[17].text.to_i
      player_stats[:free_kicks_against][i] = data[18].text.to_i
      player_stats[:percentage_time_on_ground][i] = data[27].text.to_i
    end

    # Updates each Player model
    id = Player.find_by(last_name: last_name, first_name: first_name).id
    player_stats.keys.each do |key|
      Player.update id, key => player_stats[key]
    end

    puts "Added stats for #{ first_name } #{ last_name }"
  else  # if the url cannot be found
    @failed_players << player
    puts "Failed to add stats for #{ player.id } #{ first_name } #{ last_name }"
  end
end

puts "Scraping player stats"
Player.all.each do |player|
  scrape_player_stats player
end
puts "#{ Player.count - @failed_players.count }/#{ Player.count } players' stats scraped"
puts "Stats scrape failed for: #{ @failed_players.map{|p| [p.id, p.first_name, p.last_name].join(' ')}.join(', ') }"
