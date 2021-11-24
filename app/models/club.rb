class Club < ApplicationRecord
  has_and_belongs_to_many :fixtures
  has_many :players
  has_many :game_logs

  def wins
    fixtures.filter{ |f| f.win? self }.count
  end

  def draws
    fixtures.filter{ |f| f.draw? }.count
  end

  def losses
    fixtures.filter{ |f| f.loss? self }.count
  end

  def record
    "#{ wins }-#{ losses }#{ "-#{draws}" if draws > 0 }"
  end

  def games_played
    wins + draws + losses
  end

  def points_for
    home_points = fixtures.filter{ |f| f.isHome?(self) }.map{ |f| f.home_score }.sum
    away_points = fixtures.filter{ |f| f.isAway?(self) }.map{ |f| f.away_score }.sum
    home_points + away_points
  end

  def points_against
    home_points = fixtures.filter{ |f| f.isHome?(self) }.map{ |f| f.away_score }.sum
    away_points = fixtures.filter{ |f| f.isAway?(self) }.map{ |f| f.home_score }.sum
    home_points + away_points
  end

  def percentage
    (points_for.to_f / points_against * 100).round 2
  end

  def league_points
    wins * 4 + draws * 2
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
    fixtures.map{ |f| result f }
  end

  def get_all_opponents
    home = fixtures.pluck(:home_id)
    away = fixtures.pluck(:away_id)
    home
  end
end
