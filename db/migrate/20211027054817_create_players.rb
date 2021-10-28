class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :name
      t.string :first_name
      t.string :last_name
      t.integer :club_id
      t.integer :jersey

      t.string :position, :array => true, :default => []
      t.integer :fantasy_scores, :array => true, :default => []

      t.integer :kicks, :array => true, :default => []
      t.integer :marks, :array => true, :default => []
      t.integer :handballs, :array => true, :default => []
      t.integer :disposals, :array => true, :default => []
      t.integer :goals, :array => true, :default => []
      t.integer :behinds, :array => true, :default => []
      t.integer :hit_outs, :array => true, :default => []
      t.integer :tackles, :array => true, :default => []
      # t.integer :rebound_50s, :array => true, :default => []
      # t.integer :inside_50s, :array => true, :default => []
      # t.integer :clearances, :array => true, :default => []
      # t.integer :clangers, :array => true, :default => []
      t.integer :free_kicks_for, :array => true, :default => []
      t.integer :free_kicks_against, :array => true, :default => []
      # t.integer :brownlow_votes, :array => true, :default => []
      # t.integer :contested_possessions, :array => true, :default => []
      # t.integer :uncontested_possessions, :array => true, :default => []
      # t.integer :contested_marks, :array => true, :default => []
      # t.integer :marks_inside_50, :array => true, :default => []
      # t.integer :one_percenters, :array => true, :default => []
      # t.integer :bounces, :array => true, :default => []
      # t.integer :goal_assists, :array => true, :default => []
      t.integer :percentage_time_on_ground, :array => true, :default => []

      t.string :expected_dtlive_alias
    end
  end
end
