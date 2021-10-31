class Club < ApplicationRecord
  has_and_belongs_to_many :fixtures
  has_many :players

  def wins
    self.fixtures.filter{ |f| f.win? self }.count
  end

  def draws
    self.fixtures.filter{ |f| f.draw? }.count
  end

  def losses
    self.fixtures.filter{ |f| f.loss? self }.count
  end

  def record
    "#{ self.wins }-#{ self.losses }#{ "-#{self.draws}" if self.draws > 0 }"
  end

  def games_played
    self.wins + self.draws + self.losses
  end

  def points_for
    home_points = self.fixtures.filter{ |f| f.home_id == self.id }.pluck(:home_score).sum
    away_points = self.fixtures.filter{ |f| f.away_id == self.id }.pluck(:away_score).sum
    home_points + away_points
  end

  def points_against
    home_points = self.fixtures.filter{ |f| f.home_id == self.id }.pluck(:away_score).sum
    away_points = self.fixtures.filter{ |f| f.away_id == self.id }.pluck(:home_score).sum
    home_points + away_points
  end

  def percentage
    (self.points_for.to_f / self.points_against * 100).round 2
  end

  def league_points
    self.wins * 4 + self.draws * 2
  end

  def rank
    # TODO: figure out how to import ClubsHelper...sort_for_ladder
    ladder = Club.all.sort_by{|t| [ t.league_points, t.percentage, t.points_for ]}.reverse
    ladder.index(self) + 1
  end

  def result fixture
    if fixture.win? self
      'W'
    elsif fixture.loss? self
      'L'
    elsif fixture.draw?
      'D'
    end
  end

  def results
    self.fixtures.map{ |f| self.result f }
  end
end
