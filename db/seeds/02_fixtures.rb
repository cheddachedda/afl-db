require 'httparty'
require 'nokogiri'

# key = club name as it appears in finalsiren.com
# value = :name as per our Club model
@aliases = {
  clubs: {
    :'Adelaide' => 'Adelaide',
    :'Brisbane Lions' => 'Brisbane',
    :'Carlton' => 'Carlton',
    :'Collingwood' => 'Collingwood',
    :'Essendon' => 'Essendon',
    :'Fremantle' => 'Fremantle',
    :'Geelong' => 'Geelong',
    :'Gold Coast' => 'Gold Coast',
    :'GWS Giants' => 'Greater Western Sydney',
    :'Hawthorn' => 'Hawthorn',
    :'Melbourne' => 'Melbourne',
    :'North Melbourne' => 'North Melbourne',
    :'Port Adelaide' => 'Port Adelaide',
    :'Richmond' => 'Richmond',
    :'St Kilda' => 'St Kilda',
    :'Sydney' => 'Sydney',
    :'West Coast' => 'West Coast',
    :'Western Bulldogs' => 'Western Bulldogs'
  },
  grounds: {
    :"AAMI Stadium" => "Optus Stadium", # They had this one error where they called it AAMI Stadium instead of Optus Stadium
    :"Adelaide Oval" => "Adelaide Oval",
    :"Blundstone Arena" => "Blundstone Arena",
    :"Cazaly's Stadium" => "Cazaly's Stadium",
    :"Eureka Stadium" => "Mars Stadium",
    :"Gabba" => "Gabba",
    :"Manuka Oval" => "Manuka Oval",
    :"Marvel Stadium" => "Marvel Stadium",
    :"Melbourne Cricket Ground" => "MCG",
    :"Metricon Stadium" => "Metricon Stadium",
    :"Optus Stadium" => "Optus Stadium",
    :"Simonds Stadium" => "GMHBA Stadium",
    :"Sydney Cricket Ground" => "SCG",
    :"Sydney Showground Stadium" => "GIANTS Stadium",
    :"University of Tasmania Stadium" => "University of Tasmania Stadium"
  }
}

# Converts a string time to a DateTime object and applies the correct GMT offset
def apply_offset time_string
  dt = DateTime.parse time_string
  dst_end = DateTime.parse "04/04/2021 16:00"
  if (dt < dst_end)
    DateTime.parse(time_string + ' +11')
  else
    DateTime.parse(time_string + ' +10')
  end
end

def scrape_fixtures
  url = 'https://www.finalsiren.com/Results.asp?SeasonID=2021&Round=All'
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page.body)

  rows = parsed_page.css('tr')

  round_no = 0

  rows.each do |row|
    # The rows don't have classes to differentiate, but they can be differentiated by `.children.size`
    # Rows with 1 children = round label or empty row
    # Rows with 9 children = header row
    # Rows with 16 children = game data
    case row.children.size
    when 1
      if row.text.include? 'Round '
        round_no = row.text.split('Round ').last.to_i
      elsif row.text.include? 'Finals Week '
        round_no = row.text.split('Finals Week ').last.to_i + 23
      end
    when 16
      # Returns an array of all columns in this row
      data = row.children.map{ |c| c.text.strip }

      # Match finalsiren.com's names to the names in our db
      home = Club.find_by_name( @aliases[:clubs][data[0].to_sym] )
      away = Club.find_by_name( @aliases[:clubs][data[7].to_sym] )
      venue = @aliases[:grounds][data[13].to_sym]

      new_fixture = Fixture.create(
        :round_no => round_no,
        :home_id => home.id,
        :home_goals_qt => data[1].split('.').first.to_i,
        :home_behinds_qt => data[1].split('.').last.to_i,
        :home_goals_ht => data[2].split('.').first.to_i,
        :home_behinds_ht => data[2].split('.').last.to_i,
        :home_goals_3qt => data[3].split('.').first.to_i,
        :home_behinds_3qt => data[3].split('.').last.to_i,
        :home_goals_ft => data[4].split('.').first.to_i,
        :home_behinds_ft => data[4].split('.').last.to_i,
        :away_id => away.id,
        :away_goals_qt => data[8].split('.').first.to_i,
        :away_behinds_qt => data[8].split('.').last.to_i,
        :away_goals_ht => data[9].split('.').first.to_i,
        :away_behinds_ht => data[9].split('.').last.to_i,
        :away_goals_3qt => data[10].split('.').first.to_i,
        :away_behinds_3qt => data[10].split('.').last.to_i,
        :away_goals_ft => data[11].split('.').first.to_i,
        :away_behinds_ft => data[11].split('.').last.to_i,
        :venue => venue,
        :datetime => apply_offset(data[14])
      )

      new_fixture.clubs << home << away

      puts "Created and associated Fixture: R#{ new_fixture.round_no }: #{ home.abbreviation } v #{ away.abbreviation }"
    end
  end
end

scrape_fixtures

puts "#{ Fixture.count } fixtures created and associated"
