class FixturesController < ApplicationController
  def index
    @rounds = Fixture.all.pluck(:round).uniq
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
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
