class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :club_id
      # t.integer :jersey

      t.string :position, :array => true, :default => []

      # Only required for '03a_players_simple' seed
      t.integer :fantasy_scores, :array => true, :default => []

      # t.integer :kicks, :array => true, :default => []
      # t.integer :marks, :array => true, :default => []
      # t.integer :handballs, :array => true, :default => []
      # t.integer :goals, :array => true, :default => []
      # t.integer :behinds, :array => true, :default => []
      # t.integer :hit_outs, :array => true, :default => []
      # t.integer :tackles, :array => true, :default => []
      # t.integer :free_kicks_for, :array => true, :default => []
      # t.integer :free_kicks_against, :array => true, :default => []
      # t.integer :percentage_time_on_ground, :array => true, :default => []
    end
  end
end
