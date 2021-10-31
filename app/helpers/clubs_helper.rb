module ClubsHelper
  def sort_for_ladder
    Club.all.sort_by{|club| [ club.league_points, club.percentage, club.points_for ]}.reverse
  end
end
