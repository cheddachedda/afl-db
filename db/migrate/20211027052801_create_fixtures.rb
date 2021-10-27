class CreateFixtures < ActiveRecord::Migration[6.1]
  def change
    create_table :fixtures do |t|
      t.string :round
      t.string :datetime
      t.string :venue
      t.string :home
      t.string :away
      t.integer :home_score
      t.integer :away_score
    end
  end
end
