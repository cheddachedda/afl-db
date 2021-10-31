Club.destroy_all

clubs = [
  { :name => 'Adelaide Crows', :abbreviation => 'ADE', :fixtures_alias => 'Adelaide Crows', :afl_tables_alias => 'Adelaide' },
  { :name => 'Brisbane Lions', :abbreviation => 'BRL', :fixtures_alias => 'Brisbane Lions', :afl_tables_alias => 'Brisbane Lions' },
  { :name => 'Carlton Blues', :abbreviation => 'CAR', :fixtures_alias => 'Carlton', :afl_tables_alias => 'Carlton' },
  { :name => 'Collingwood Magpies', :abbreviation => 'COL', :fixtures_alias => 'Collingwood', :afl_tables_alias => 'Collingwood' },
  { :name => 'Essendon Bombers', :abbreviation => 'ESS', :fixtures_alias => 'Essendon', :afl_tables_alias => 'Essendon' },
  { :name => 'Fremantle Dockers', :abbreviation => 'FRE', :fixtures_alias => 'Fremantle', :afl_tables_alias => 'Fremantle' },
  { :name => 'Geelong Cats', :abbreviation => 'GEE', :fixtures_alias => 'Geelong Cats', :afl_tables_alias => 'Geelong' },
  { :name => 'Gold Coast Suns', :abbreviation => 'GCS', :fixtures_alias => 'Gold Coast Suns', :afl_tables_alias => 'Gold Coast' },
  { :name => 'Greater Western Sydney Giants', :abbreviation => 'GWS', :fixtures_alias => 'GWS Giants', :afl_tables_alias => 'Greater Western Sydney' },
  { :name => 'Hawthorn Hawks', :abbreviation => 'HAW', :fixtures_alias => 'Hawthorn', :afl_tables_alias => 'Hawthorn' },
  { :name => 'Melbourne Demons', :abbreviation => 'MEL', :fixtures_alias => 'Melbourne', :afl_tables_alias => 'Melbourne' },
  { :name => 'North Melbourne Kangaroos', :abbreviation => 'NME', :fixtures_alias => 'North Melbourne', :afl_tables_alias => 'North Melbourne' },
  { :name => 'Port Adelaide Power', :abbreviation => 'PTA', :fixtures_alias => 'Port Adelaide', :afl_tables_alias => 'Port Adelaide' },
  { :name => 'Richmond Tigers', :abbreviation => 'RIC', :fixtures_alias => 'Richmond', :afl_tables_alias => 'Richmond' },
  { :name => 'St Kilda Saints', :abbreviation => 'STK', :fixtures_alias => 'St Kilda', :afl_tables_alias => 'St Kilda' },
  { :name => 'Sydney Swans', :abbreviation => 'SYD', :fixtures_alias => 'Sydney Swans', :afl_tables_alias => 'Sydney' },
  { :name => 'West Coast Eagles', :abbreviation => 'WCE', :fixtures_alias => 'West Coast Eagles', :afl_tables_alias => 'West Coast' },
  { :name => 'Western Bulldogs', :abbreviation => 'WBD', :fixtures_alias => 'Western Bulldogs', :afl_tables_alias => 'Western Bulldogs' }
]

puts "Creating clubs"
clubs.each do |club|
  Club.create :name => club[:name], :abbreviation => club[:abbreviation]
  puts "Created #{ club[:name] }"
end

puts "#{ Club.count } clubs created"
