class Club < ApplicationRecord
  has_and_belongs_to_many :fixtures
  has_many :players

  def home_fixtures
    fixtures = self.fixtures.where(home_id: self.id)
  end

  def away_fixtures
    fixtures = self.fixtures.where(away_id: self.id)
  end

  def home_wins
    self.home_fixtures.filter{|f| f.home_win && f.is_regular_season}.count
  end

  def home_draws
    self.home_fixtures.filter{|f| f.home_draw && f.is_regular_season}.count
  end

  def home_losses
    self.home_fixtures.filter{|f| f.home_loss && f.is_regular_season}.count
  end

  def home_points_for
    self.home_fixtures.filter{|f| f.is_regular_season}.pluck(:home_score).sum
  end

  def home_points_against
    self.home_fixtures.filter{|f| f.is_regular_season}.pluck(:away_score).sum
  end

  def away_wins
    self.away_fixtures.filter{|f| f.away_win && f.is_regular_season}.count
  end

  def away_draws
    self.away_fixtures.filter{|f| f.away_draw && f.is_regular_season}.count
  end

  def away_losses
    self.away_fixtures.filter{|f| f.away_loss && f.is_regular_season}.count
  end

  def away_points_for
    self.away_fixtures.filter{|f| f.is_regular_season}.pluck(:away_score).sum
  end

  def away_points_against
    self.away_fixtures.filter{|f| f.is_regular_season}.pluck(:home_score).sum
  end

  def wins
    self.home_wins + self.away_wins
  end

  def draws
    self.home_draws + self.away_draws
  end

  def losses
    self.home_losses + self.away_losses
  end

  def points_for
    self.home_points_for + self.away_points_for
  end

  def points_against
    self.home_points_against + self.away_points_against
  end

  def games_played
    self.wins + self.draws + self.losses
  end

  def percentage
    (self.points_for.to_f / self.points_against * 100).round 2
  end

  def league_points
    self.wins * 4 + self.draws * 2
  end
end
