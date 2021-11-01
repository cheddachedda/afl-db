puts "Associating Fixtures and Players"
@associated_fixtures = 0
@associated_players = 0

Player.all.each do |player|
  player.fantasy_scores.each_with_index do |value, index|
    unless value.nil?
      fixture = player.club.fixtures.find_by(round_id: index + 1)
      unless fixture.nil?
        player.fixtures << fixture
        @associated_fixtures += 1
        puts "Associated #{ fixture.matchup } with #{ player.name }"
      end
    end
  end

  @associated_players += 1
end

puts "Associated #{ @associated_fixtures } fixtures for #{ @associated_players } players"
