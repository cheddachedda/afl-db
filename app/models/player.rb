class Player < ApplicationRecord
  belongs_to :club, :optional => true
  has_and_belongs_to_many :fixtures

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
