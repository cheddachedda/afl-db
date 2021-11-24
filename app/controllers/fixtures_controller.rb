class FixturesController < ApplicationController
  def index
    @fixtures = Fixture.all
  end

  def round
    @fixtures = Fixture.where(round_no: params[:round])
  end

  def show
    @round = params[:round] # necessary for :breadcrumbs
    @fixture = Fixture.find params[:id]
    @r = @fixture.round_no - 1
  end
end
