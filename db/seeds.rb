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
