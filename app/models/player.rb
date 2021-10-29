class Player < ApplicationRecord
  belongs_to :club, :optional => true
  has_and_belongs_to_many :fixtures

  def name
    "#{ self.first_name } #{ self.last_name }"
  end

  def short_name
    "#{ self.first_name[0] }. #{ self.last_name }"
  end

  def disposals
    scores = []
    (0..27).each do |i|
      unless self.percentage_time_on_ground[i].nil?
        scores[i] = self.kicks[i] + self.handballs[i]
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
        scoring = {
          :kicks => self.kicks[i] * 3,
          :marks => self.marks[i] * 3,
          :handballs => self.handballs[i] * 2,
          :goals => self.goals[i] * 6,
          :behinds => self.behinds[i] * 1,
          :hit_outs => self.hit_outs[i] * 1,
          :free_kicks_for => self.free_kicks_for[i] * 1,
          :free_kicks_against => self.free_kicks_against[i] * -3,
        }
        scores << scoring.values.sum
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

  def get_all_round_names
    Fixture.all.map{ |f| f.round }.uniq
  end

  def get_all_opponents
    self.get_all_round_names.map do |r|
      club_id = self.club_id
      fixture = self.fixtures.find_by(round_id: r)
      unless fixture.nil?
        opp_id = club_id == fixture.home_id ? fixture.away_id : fixture.home_id
        Club.find(opp_id).abbreviation
      end
    end
  end

  def filter_by_query query, players = Player.all
    players.filter{ |p| p.name.downcase.include? query.downcase }
  end

  def filter_by_club club_abbr, players = Player.all
    players.filter{ |p| p.club.abbreviation == club_abbr }
  end

  def filter_by_pos pos, players = Player.all
    players.filter{ |p| p.position.include? pos }
  end
end
