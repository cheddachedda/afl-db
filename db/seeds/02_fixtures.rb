require 'httparty'
require 'nokogiri'
require 'pry'

Fixture.destroy_all

# key = club name as it appears in fixturedownload.com
# value = :name as per our Club model
@fixtures_aliases = {
  :'Adelaide Crows' => 'Adelaide Crows',
  :'Brisbane Lions' => 'Brisbane Lions',
  :'Carlton' => 'Carlton Blues',
  :'Collingwood' => 'Collingwood Magpies',
  :'Essendon' => 'Essendon Bombers',
  :'Fremantle' => 'Fremantle Dockers',
  :'Geelong Cats' => 'Geelong Cats',
  :'Gold Coast Suns' => 'Gold Coast Suns',
  :'GWS Giants' => 'Greater Western Sydney Giants',
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

def scrape_fixtures
  url = "https://fixturedownload.com/results/afl-2021"
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page.body)

  # Each fixture is contained within each <tr>
  rows = parsed_page.css('tbody').css('tr')

  rows.each do |row|
    data = row.css('td')

    # Parse round_id from text
    round_id = case data[0].text
    when 'Finals W1'
      round_id = 24
    when 'Semi Finals'
      round_id = 25
    when 'Prelim Finals'
      round_id = 26
    when 'Grand Final'
      round_id = 27
    else
      round_id = data[0].text.to_i
    end

    new_fixture = Fixture.create(
      :round_id => round_id,
      :datetime => DateTime.parse(data[1].text).new_offset(
        DateTime.parse("04/04/2021 16:00") - DateTime.parse(data[1].text) >= 0 ?
        "+10:00" : "+11:00"
      ),
      :venue => data[2].text,
      :home_id => Club.find_by( name: @fixtures_aliases[data[3].text.to_sym] ).id,
      :home_score => data[5].text.split(' - ')[0].to_i,
      :away_id => Club.find_by( name: @fixtures_aliases[data[4].text.to_sym] ).id,
      :away_score => data[5].text.split(' - ')[1].to_i
    )

    # Associate Clubs to Fixtures
    new_fixture.clubs << Club.find( new_fixture[:home_id] ) << Club.find( new_fixture[:away_id] )

    puts "R#{ round_id }: #{ new_fixture[:home_id] } v #{ new_fixture[:away_id] } created"
  end
end

puts "Scraping fixtures"
scrape_fixtures
puts "#{ Fixture.count } games created and associated"
