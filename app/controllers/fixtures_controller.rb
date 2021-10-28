class FixturesController < ApplicationController
  def index
    redirect_to round_path(Fixture.last.round)
  end

  def round
    @rounds = Fixture.all.pluck(:round).uniq
    @round = params[:round_id]
    @fixtures = Fixture.where("round = '#{ @round }'")
  end

  def new
  end

  def create
  end

  def show
    @round = params[:round] # necessary for :breadcrumbs
    @fixture = Fixture.find params[:id]
    @players = @fixture.players
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
