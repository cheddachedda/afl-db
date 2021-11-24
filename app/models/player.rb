class Player < ApplicationRecord
  belongs_to :club, :optional => true
  has_many :game_logs

  def name
    first_name + ' ' + last_name
  end

  def get_all_opponents
    club.get_all_opponents
  end

  def games_played
    fantasy_scores.filter{ |score| score.present? }.count
  end

  def average_fantasy_score
    unless fantasy_scores.count
      (fantasy_scores.sum.to_f / fantasy_scores.count).round(1)
    else
      nil
    end
  end

  def fantasy_scores
    GameLog.where(player_id: self.id).map{ |gl| gl.fantasy_score }
  end
end
