class CreateClubsFixtures < ActiveRecord::Migration[6.1]
  def change
    create_table :clubs_fixtures, :id => false do |t|
      t.integer :club_id
      t.integer :fixture_id
    end
  end
end
