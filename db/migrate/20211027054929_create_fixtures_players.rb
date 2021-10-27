class CreateFixturesPlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :fixtures_players, :id => false do |t|
      t.integer :fixture_id
      t.integer :player_id
    end
  end
end
