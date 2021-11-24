class PlayersController < ApplicationController
  def index
    all_players = Player.all.sort_by{ |p| p.average_fantasy_score }

    # with_query_filter = all_players.filter{ |p| p.name.downcase.include? params[:query].downcase }
    #
    # with_club_fitler = with_query_filter.filter do |p|
    #   if params[:club].empty?
    #     with_query_filter
    #   else
    #     p.club.abbreviation == params[:club]
    #   end
    # end
    #
    # with_pos_fitler = with_club_fitler.filter do |p|
    #   if params[:pos].empty?
    #     with_club_fitler
    #   else
    #     p.position.include? params[:pos]
    #   end
    # end

    @players = all_players

    @rounds = Fixture.all.map{ |f| f.round }.uniq
  end

  def show
    @player = Player.find params[:id]
    @editable = [ "first_name", "last_name", "club_id", "jersey", "position" ]
  end
end
