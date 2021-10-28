class FixturesController < ApplicationController
  def index
    redirect_to round_path(Fixture.last.round)
  end

  def round
    @rounds = Fixture.all.map{ |f| f.round }.uniq
    @round = params[:round]
    @fixtures = Fixture.all.filter{ |f| f.round == @round }
  end

  def show
    @round = params[:round] # necessary for :breadcrumbs
    @fixture = Fixture.find params[:id]
    @r = @fixture.round_id - 1
  end
end
