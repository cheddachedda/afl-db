clubs = [
  { :name => 'Adelaide Crows', :abbreviation => 'ADE' },
  { :name => 'Brisbane Lions', :abbreviation => 'BRL' },
  { :name => 'Carlton Blues', :abbreviation => 'CAR' },
  { :name => 'Collingwood Magpies', :abbreviation => 'COL' },
  { :name => 'Essendon Bombers', :abbreviation => 'ESS' },
  { :name => 'Fremantle Dockers', :abbreviation => 'FRE' },
  { :name => 'Geelong Cats', :abbreviation => 'GEE' },
  { :name => 'Gold Coast Suns', :abbreviation => 'GCS' },
  { :name => 'Greater Western Sydney Giants', :abbreviation => 'GWS' },
  { :name => 'Hawthorn Hawks', :abbreviation => 'HAW' },
  { :name => 'Melbourne Demons', :abbreviation => 'MEL' },
  { :name => 'North Melbourne Kangaroos', :abbreviation => 'NME' },
  { :name => 'Port Adelaide Power', :abbreviation => 'PTA' },
  { :name => 'Richmond Tigers', :abbreviation => 'RIC' },
  { :name => 'St Kilda Saints', :abbreviation => 'STK' },
  { :name => 'Sydney Swans', :abbreviation => 'SYD' },
  { :name => 'West Coast Eagles', :abbreviation => 'WCE' },
  { :name => 'Western Bulldogs', :abbreviation => 'WBD' }
]

puts "Creating clubs"
clubs.each do |club|
  Club.create :name => club[:name], :abbreviation => club[:abbreviation]
  puts "Created #{ club[:name] }"
end

puts "#{ Club.count } clubs created"
