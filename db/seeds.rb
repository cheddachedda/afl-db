require "date"
require "httparty"
require "nokogiri"

Club.destroy_all

c1 = Club.create :name => 'Adelaide Crows', :abbreviation => 'ADE', :fixtures_alias => 'Adelaide Crows', :afl_tables_alias => 'Adelaide'
c2 = Club.create :name => 'Brisbane Lions', :abbreviation => 'BRL', :fixtures_alias => 'Brisbane Lions', :afl_tables_alias => 'Brisbane Lions'
c3 = Club.create :name => 'Carlton Blues', :abbreviation => 'CAR', :fixtures_alias => 'Carlton', :afl_tables_alias => 'Carlton'
c4 = Club.create :name => 'Collingwood Magpies', :abbreviation => 'COL', :fixtures_alias => 'Collingwood', :afl_tables_alias => 'Collingwood'
c5 = Club.create :name => 'Essendon Bombers', :abbreviation => 'ESS', :fixtures_alias => 'Essendon', :afl_tables_alias => 'Essendon'
c6 = Club.create :name => 'Fremantle Dockers', :abbreviation => 'FRE', :fixtures_alias => 'Fremantle', :afl_tables_alias => 'Fremantle'
c7 = Club.create :name => 'Geelong Cats', :abbreviation => 'GEE', :fixtures_alias => 'Geelong Cats', :afl_tables_alias => 'Geelong'
c8 = Club.create :name => 'Gold Coast Suns', :abbreviation => 'GCS', :fixtures_alias => 'Gold Coast Suns', :afl_tables_alias => 'Gold Coast'
c9 = Club.create :name => 'Greater Western Sydney Giants', :abbreviation => 'GWS', :fixtures_alias => 'GWS Giants', :afl_tables_alias => 'Greater Western Sydney'
c10 = Club.create :name => 'Hawthorn Hawks', :abbreviation => 'HAW', :fixtures_alias => 'Hawthorn', :afl_tables_alias => 'Hawthorn'
c11 = Club.create :name => 'Melbourne Demons', :abbreviation => 'MEL', :fixtures_alias => 'Melbourne', :afl_tables_alias => 'Melbourne'
c12 = Club.create :name => 'North Melbourne Kangaroos', :abbreviation => 'NME', :fixtures_alias => 'North Melbourne', :afl_tables_alias => 'North Melbourne'
c13 = Club.create :name => 'Port Adelaide Power', :abbreviation => 'PTA', :fixtures_alias => 'Port Adelaide', :afl_tables_alias => 'Port Adelaide'
c14 = Club.create :name => 'Richmond Tigers', :abbreviation => 'RIC', :fixtures_alias => 'Richmond', :afl_tables_alias => 'Richmond'
c15 = Club.create :name => 'St Kilda Saints', :abbreviation => 'STK', :fixtures_alias => 'St Kilda', :afl_tables_alias => 'St Kilda'
c16 = Club.create :name => 'Sydney Swans', :abbreviation => 'SYD', :fixtures_alias => 'Sydney Swans', :afl_tables_alias => 'Sydney'
c17 = Club.create :name => 'West Coast Eagles', :abbreviation => 'WCE', :fixtures_alias => 'West Coast Eagles', :afl_tables_alias => 'West Coast'
c18 = Club.create :name => 'Western Bulldogs', :abbreviation => 'WBD', :fixtures_alias => 'Western Bulldogs', :afl_tables_alias => 'Western Bulldogs'

puts "#{ Club.count } clubs created"


################################# FIXTURES #####################################

Fixture.destroy_all

def scrape_fixtures
  url = "https://fixturedownload.com/results/afl-2021"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page.body)

  rows = parsed_page.css('tr').drop 1

  rows.each do |row|
    data = row.css('td')

    # Shorten round name
    round = case data[0].text
    when 'Finals W1'
      'FW1'
    when 'Semi Finals'
      'SF'
    when 'Prelim Finals'
      'PF'
    when 'Grand Final'
      'GF'
    else
      "R#{data[0].text}"
    end

    new_fixture = Fixture.create(
      :round => round,
      :datetime => DateTime.parse(data[1].text).new_offset(
        DateTime.parse("04/04/2021 16:00") - DateTime.parse(data[1].text) >= 0 ?
        "+10:00" : "+11:00"
      ),
      :venue => data[2].text,
      :home => data[3].text,
      :away => data[4].text,
      :home_score => data[5].text.split(' - ')[0].to_i,
      :away_score => data[5].text.split(' - ')[1].to_i
    )
    new_fixture.clubs << Club.find_by(:fixtures_alias => data[3].text) << Club.find_by(:fixtures_alias => data[4].text)
    puts "#{ round } #{ new_fixture[:home] } v #{ new_fixture[:away] } created"
  end
end

scrape_fixtures
puts "#{ Fixture.count } games created and associated"

################################## PLAYERS #####################################

Player.destroy_all

# I. Scrape for basic player data

def scrape_players
  url = "https://afltables.com/afl/stats/2021.html"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page.body)

  tables = parsed_page.css('.sortable')
  tables.each do |t|
    club = t.css('a').first.text
    t.css('tbody')[0].css('tr').each do |tr|
      new_player = Player.new(
        :name => tr.children[1].text,
        :first_name => tr.children[1].text.split(', ')[1],
        :last_name => tr.children[1].text.split(', ')[0],
        :club => Club.find_by(afl_tables_alias: club),
        :jersey => tr.children[0].text.to_i,
      )
      new_player[:expected_dtlive_alias] = "#{ new_player[:first_name][0] } #{ new_player[:last_name]}"
      new_player.save
      puts "#{ new_player[:name] } created"
    end
  end
end

scrape_players

# II. Scrape for all game-by-game stats from afltables.com

def scrape_player_stats player
  puts "Adding stats for #{ player.name }"
  first_name = player.first_name
  last_name = player.last_name

  url = "https://afltables.com/afl/stats/players/#{ first_name[0] }/#{ first_name }_#{ last_name.gsub(' ', '_') }.html"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page.body)

  result = false
  unless parsed_page.css('.sortable').empty?

    rows = parsed_page.css('.sortable').last.css('tbody')[0].css('tr')

    categories = [ :kicks, :marks, :handballs, :goals, :behinds, :hit_outs, :tackles, :free_kicks_for, :free_kicks_against ]

    # Initialise player hash
    player = {}
    categories.each do |cat|
      player[:name] = "#{ first_name } #{ last_name }"
      player[cat] = []
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

      player[:kicks][round - 1] = data[5].text.to_i
      player[:handballs][round - 1] = data[6].text.to_i
      player[:marks][round - 1] = data[7].text.to_i
      player[:goals][round - 1] = data[9].text.to_i
      player[:behinds][round - 1] = data[10].text.to_i
      player[:hit_outs][round - 1] = data[11].text.to_i
      player[:tackles][round - 1] = data[12].text.to_i
      player[:free_kicks_for][round - 1] = data[17].text.to_i
      player[:free_kicks_against][round - 1] = data[18].text.to_i
    end

    # Updates each Player model
    id = Player.find_by(name: "#{last_name}, #{first_name}").id
    player.keys.drop(1).each do |key|
      Player.update id, key => player[key]
    end

    result = true
  end

  result
end

stats_scrape_count = 0
Player.all.each do |player|
  if scrape_player_stats player
    stats_scrape_count += 1
  end
end
puts "#{ stats_scrape_count } of #{ Player.count } players' stats scraped"

# III. Scrape for fantasy positions

# Web Scrape
def fantasy_scraper
  url = "http://dtlive.com.au/afl/dataview.php"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page.body)

  rows = parsed_page.css('tr')
  players = []

  # Iterate through all rows (except 1 header row and 1 footer row)
  (1..rows.count-2).each do |i|
    player = {
      name: rows[i].children[1].text,
      position: rows[i].children[2].text.upcase.split(','),
      fantasy_scores: (14..36).map { |col|
        rows[i].children[col].text.empty? ?
        nil : rows[i].children[col].text.to_i
      }
    }
    player[:games] = player[:fantasy_scores].select{|n|n}.count
    player[:average] = player[:fantasy_scores].select{|n|n}.sum.to_f / player[:games]

    players << player
  end

  count = 0
  # Updates each Player model
  players.each do |player|
    id = nil

    if Player.find_by(expected_dtlive_alias: player[:name])
      id = Player.find_by(expected_dtlive_alias: player[:name]).id
    end

    unless id == nil
      puts "Updating fantasy info for #{ Player.find(id).name }"
      Player.update id, :position => player[:position], :fantasy_scores => player[:fantasy_scores]
      count += 1
    end
  end
  puts "#{ count } of #{ Player.count } players' dtlive data added"
end

fantasy_scraper

####################### ASSOCIATE FIXTURES + PLAYERS ###########################

puts "Associating Fixtures and Players"
association_count = 0
fixtures_and_players_start_time = Time.new
Player.all.each do |player|
  puts "Associating fixtures for #{ player.name }"
  unless player.club.nil?
    player.club.fixtures.each do |fixture|
      player.fixtures << fixture
      association_count += 1
    end
  end
end

puts "Created Fixture-Player associations for #{ association_count } players"

# rails db:drop
# rails db:create
# rails db:migrate
# rails db:seed
