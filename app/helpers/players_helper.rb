module PlayersHelper
  def get_score_class score
    if score.nil?
      return
    elsif score >= 120
      return 'score-elite'
    elsif score >= 100
      return 'score-high'
    elsif score >= 80
      return 'score-good'
    elsif score >= 60
      return 'score-average'
    elsif score >= 40
      return 'score-low'
    else
      return 'score-poor'
    end
  end
end
