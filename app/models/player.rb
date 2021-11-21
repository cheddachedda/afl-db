class Player < ApplicationRecord
  belongs_to :club, :optional => true
  has_many :game_logs

  def get_all_opponents
    self.club.get_all_opponents
  end

  def games_played
    self.fantasy_scores.filter{ |score| score.present? }.count
  end

  def average_fantasy_score
    (self.fantasy_scores.filter{ |score| score.present? }.sum / self.games_played.to_f).round(1)
  end
end
