class Fixture < ApplicationRecord
  has_and_belongs_to_many :clubs
  has_many :game_logs

  def round
    case round_no
    when 24
      'FW1'
    when 25
      'SF'
    when 26
      'PF'
    when 27
      'GF'
    else
      round_no.to_s
    end
  end

  def date
    datetime.strftime('%a %d %b')
  end

  def time
    datetime.strftime('%l:%M%P')
  end

  def home
    Club.find home_id
  end

  def away
    Club.find away_id
  end

  def isHome? club
    club === home
  end

  def isAway? club
    club === away
  end

  def home_score
    home_goals_ft * 6 + home_behinds_ft
  end

  def away_score
    away_goals_ft * 6 + away_behinds_ft
  end

  def matchup
    "#{ home.abbreviation } v #{ away.abbreviation }"
  end

  def winner
    if home_score > away_score
      Club.find home_id
    elsif away_score > home_score
      Club.find away_id
    end
  end

  def loser
    if home_score < away_score
      Club.find home_id
    elsif away_score < home_score
      Club.find away_id
    end
  end

  def is_regular_season
    round_no < 24
  end

  def is_finals
    round_no > 23
  end

  def short_name
    "#{ home.abbreviation } v #{ away.abbreviation }"
  end

  def home_players
    home.players
             .filter{ |p| p.club_id == home_id && p.fantasy_scores[round_no - 1] }
             .sort_by{|p| p.fantasy_scores[round_no - 1]}.reverse
  end

  def away_players
    away.players
             .filter{ |p| p.club_id == away_id && p.fantasy_scores[round_no - 1] }
             .sort_by{|p| p.fantasy_scores[round_no - 1]}.reverse
  end

  def draw?
    home_score == away_score
  end

  def win? team
    team == winner
  end

  def loss? team
    team == loser
  end
end
