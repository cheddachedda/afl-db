class Player < ApplicationRecord
  belongs_to :club, :optional => true
  has_and_belongs_to_many :fixtures

  def get_stats_by_fixture_id id
    i = self.fixtures.index{ |f| f.id == id } - 1
    stats = {
      :played => !self.percentage_time_on_ground[i].nil?,
      :fantasy_score => self.fantasy_score[i],
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
