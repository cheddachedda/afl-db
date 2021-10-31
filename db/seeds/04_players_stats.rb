require 'httparty'
require 'nokogiri'

@failed_players = []

# Scrape for a specific player's complete game-by-game stats from afltables.com
def scrape_player_stats player
  first_name = player.first_name
  last_name = player.last_name

  url = "https://afltables.com/afl/stats/players/#{ first_name[0] }/#{ first_name }_#{ last_name.gsub(' ', '_') }.html"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page.body)

  unless parsed_page.css('.sortable').empty?

    rows = parsed_page.css('.sortable').last.css('tbody')[0].css('tr')

    categories = [ :kicks, :marks, :handballs, :goals, :behinds, :hit_outs, :tackles, :free_kicks_for, :free_kicks_against, :percentage_time_on_ground ]

    # Initialises player hash with blank arrays, so that each round's stats can be entered at a specific index.
    # This allows for DNPs and byes to be added as nils.
    player_stats = {}
    categories.each do |cat|
      player_stats[:name] = "#{ first_name } #{ last_name }"
      player_stats[cat] = []
    end

    # Add each stat
    rows.each do |row|
      data = row.css('td')

      # Adds stat each a specific `round` in order to create nil values for DNPs
      round = case data[2].text
      when 'EF'
        round = 24
      when 'SF'
        round = 25
      when 'PF'
        round = 26
      when 'GF'
        round = 27
      else
        round = data[2].text.to_i
      end

      player_stats[:kicks][round - 1] = data[5].text.to_i
      player_stats[:marks][round - 1] = data[6].text.to_i
      player_stats[:handballs][round - 1] = data[7].text.to_i
      player_stats[:goals][round - 1] = data[9].text.to_i
      player_stats[:behinds][round - 1] = data[10].text.to_i
      player_stats[:hit_outs][round - 1] = data[11].text.to_i
      player_stats[:tackles][round - 1] = data[12].text.to_i
      player_stats[:free_kicks_for][round - 1] = data[17].text.to_i
      player_stats[:free_kicks_against][round - 1] = data[18].text.to_i
      player_stats[:percentage_time_on_ground][round - 1] = data[27].text.to_i
    end

    # Updates each Player model
    id = Player.find_by(last_name: last_name, first_name: first_name).id
    player_stats.keys.drop(1).each do |key|
      Player.update id, key => player_stats[key]
    end

    puts "Added stats for #{ first_name } #{ last_name }"
  else  # if the player's url cannot be found
    @failed_players << "#{ player.first_name } #{ player.last_name }"
    puts "Failed to add stats for #{ first_name } #{ last_name }"
  end
end

puts "Scraping player stats"
Player.all.each do |player|
  scrape_player_stats player
end
puts "#{ Player.count - @failed_players.count }/#{ Player.count } players' stats scraped"
puts "Stats scrape failed for: #{ @failed_players.join(', ') }"
