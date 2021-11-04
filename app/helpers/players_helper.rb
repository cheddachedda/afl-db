module PlayersHelper
  def get_score_class score
    if score.nil?
      return
    elsif score >= 150
      return 'score-elite'
    elsif score >= 100
      return 'score-high'
    elsif score >= 75
      return 'score-good'
    elsif score >= 50
      return 'score-average'
    elsif score >= 25
      return 'score-low'
    else
      return 'score-poor'
    end
  end
end
