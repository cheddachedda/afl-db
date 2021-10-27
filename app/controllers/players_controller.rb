class PlayersController < ApplicationController
  def index
    @players = Player.all
  end

  def new
  end

  def create
  end

  def show
    @player = Player.find params[:id]
    @editable = [ "first_name", "last_name", "club_id", "jersey", "position" ]

    @opponents = @player.club.fixtures.map{ |f| f.club_ids[0] == @player.club_id ? f.club_ids[1] : f.club_ids[0] }
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
