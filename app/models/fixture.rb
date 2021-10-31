class Fixture < ApplicationRecord
  has_and_belongs_to_many :clubs
  has_and_belongs_to_many :players

  def round
    case self.round_id
    when 24
      'FW1'
    when 25
      'SF'
    when 26
      'PF'
    when 27
      'GF'
    else
      self.round_id.to_s
    end
  end

  def home
    Club.find home_id
  end

  def away
    Club.find away_id
  end

  def matchup
    "#{ self.home.abbreviation } v #{ self.away.abbreviation }"
  end

  def winner
    if self.home_score > self.away_score
      Club.find self.home_id
    elsif self.away_score > self.home_score
      Club.find self.away_id
    end
  end

  def loser
    if self.home_score < self.away_score
      Club.find self.home_id
    elsif self.away_score < self.home_score
      Club.find self.away_id
    end
  end

  def is_regular_season
    self.round_id < 24
  end

  def is_finals
    self.round_id > 23
  end

  def short_name
    "#{ self.home.abbreviation } v #{ self.away.abbreviation }"
  end

  def home_players
    self.players
        .filter{ |p| p.club_id == self.home_id && p.fantasy_scores[self.round_id - 1] }
        .sort_by{|p| p.fantasy_scores[self.round_id - 1]}.reverse
  end

  def away_players
    self.players
        .filter{ |p| p.club_id == self.away_id && p.fantasy_scores[self.round_id - 1] }
        .sort_by{|p| p.fantasy_scores[self.round_id - 1]}.reverse
  end

  def draw?
    self.home_score == self.away_score
  end

  def win? team
    team == self.winner
  end

  def loss? team
    team == self.loser
  end
end
