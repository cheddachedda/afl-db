class GameLog < ApplicationRecord
  belongs_to :player
  belongs_to :fixture
  belongs_to :club

  def fantasy_score
    [
      kicks * 3,
      marks * 3,
      handballs * 2,
      goals * 6,
      behinds * 1,
      hit_outs * 1,
      tackles * 4,
      free_kicks_for * 1,
      free_kicks_against * -3
    ].sum
  end
end
