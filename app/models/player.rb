class Player < ApplicationRecord
  belongs_to :club, :optional => true
  has_and_belongs_to_many :fixtures

  def disposals
    scores = []
    (0..27).each do |i|
      if self.percentage_time_on_ground.nil?
        scores << nil
      else
        scores << self.kicks + self.marks
      end
    end
    scores
  end

  def fantasy_scores
    scores = []
    (0..27).each do |i|
      if self.percentage_time_on_ground[i].nil?
        scores << nil
      else
        score = 0
        scoring = {
          :kicks => 3,
          :marks => 3,
          :handballs => 2,
          :goals => 6,
          :behinds => 1,
          :hit_outs => 1,
          :free_kicks_for => 1,
          :free_kicks_against => -3,
        }
        scoring.keys.each { |key| score += self[key][i] * scoring[key] }
        scores << score
      end
    end
    scores
  end

  def games_played
    self.percentage_time_on_ground.filter{|n| n}.count
  end

  def average_fantasy_score
    if games_played > 0 && self.fantasy_scores.count > 0
      (self.fantasy_scores.filter{|n| n}.sum / self.games_played.to_f).round 2
    end
  end

  def get_stats_by_round_id id
    i = self.fixtures.index{ |f| f.round_id == id } - 1
    stats = {
      :played => !self.percentage_time_on_ground[i].nil?,
      :fantasy_scores => self.fantasy_scores[i],
      :kicks => self.kicks[i],
      :marks => self.marks[i],
      :handballs => self.handballs[i],
      :disposals => self.disposals[i],
      :goals => self.goals[i],
      :behinds => self.behinds[i],
      :hit_outs => self.hit_outs[i],
      :free_kicks_for => self.free_kicks_for[i],
      :free_kicks_against => self.free_kicks_against[i],
      :percentage_time_on_ground => self.percentage_time_on_ground[i],
    }
  end
end
