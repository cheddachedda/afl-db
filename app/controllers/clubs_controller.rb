class ClubsController < ApplicationController
  def index
    @clubs = Club.all.sort_by{ |club| [ club.league_points, club.percentage ] }.reverse
  end

  def show
    @club = Club.find params[:id]
    @players = @club.players
  end
end
