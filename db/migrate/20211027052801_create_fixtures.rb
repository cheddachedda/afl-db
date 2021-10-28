class CreateFixtures < ActiveRecord::Migration[6.1]
  def change
    create_table :fixtures do |t|
      t.integer :round_id
      t.datetime :datetime
      t.string :venue
      t.integer :home_id
      t.integer :away_id
      t.integer :home_score
      t.integer :away_score
    end
  end
end
