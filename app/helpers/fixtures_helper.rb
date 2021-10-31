module FixturesHelper
  def get_all_rounds
    Fixture.pluck(:round).uniq
  end
end
