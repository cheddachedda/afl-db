class CreateGameLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :game_logs do |t|
      t.belongs_to :player
      t.belongs_to :fixture
      t.belongs_to :club
      t.integer :kicks
      t.integer :marks
      t.integer :handballs
      t.integer :goals
      t.integer :behinds
      t.integer :hit_outs
      t.integer :tackles
      t.integer :free_kicks_for
      t.integer :free_kicks_against
      t.integer :percentage_time_on_ground
      t.timestamps
    end
  end
end
