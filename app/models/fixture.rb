class Fixture < ApplicationRecord
  has_and_belongs_to_many :clubs
  has_and_belongs_to_many :players

  def home
    Club.find home_id
  end

  def away
    Club.find away_id
  end

  def home_win
    self.home_score > self.away_score
  end

  def home_draw
    self.home_score == self.away_score
  end

  def home_loss
    self.home_score < self.away_score
  end

  def away_win
    self.away_score > self.home_score
  end

  def away_draw
    self.away_score == self.home_score
  end

  def away_loss
    self.away_score < self.home_score
  end

  def is_regular_season
    self.round[0] == 'R'
  end

  def is_finals
    self.round[0] != 'R'
  end

  def short_name
    "#{ self.home.abbreviation } v #{ self.away.abbreviation }"
  end
end
