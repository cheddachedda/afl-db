class ClubsController < ApplicationController
  def index
    @clubs = Club.all
  end

  def new
  end

  def create
  end

  def show
    @club = Club.find params[:id]
    @keys = [ :id, :name, :abbreviation, :fixtures_alias, :afl_tables_alias, :image ]
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
