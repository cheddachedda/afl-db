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
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
