class FixturesController < ApplicationController
  def index
    redirect_to round_path(Fixture.last.round)
  end

  def round
    @rounds = Fixture.all.pluck(:round).uniq
    @round = params[:round]
    @fixtures = Fixture.where("round = '#{ @round }'")
  end

  def new
  end

  def create
  end

  def show
    @round = params[:round] # necessary for :breadcrumbs
    @fixture = Fixture.find params[:id]
    @fixture_short_name = "#{ @fixture.clubs.first.abbreviation } v #{ @fixture.clubs.last.abbreviation }"
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
