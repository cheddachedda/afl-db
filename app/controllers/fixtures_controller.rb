class FixturesController < ApplicationController
  def index
    @fixtures = Fixture.all
  end

  def round
    @fixtures = Fixture.where(round_id: params[:round])
  end

  def show
    @round = params[:round] # necessary for :breadcrumbs
    @fixture = Fixture.find params[:id]
    @r = @fixture.round_id - 1
  end
end
