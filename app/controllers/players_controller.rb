class PlayersController < ApplicationController
  def index
    @players = Player.all.sort_by{ |p| p.average_fantasy_score || 0 }.reverse
    @rounds = Fixture.all.map{ |f| f.round }.uniq
  end

  def show
    @player = Player.find params[:id]
    @editable = [ "first_name", "last_name", "club_id", "jersey", "position" ]
  end
end
