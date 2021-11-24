module FixturesHelper
  def get_all_rounds
    Fixture.pluck(:round_no).uniq
  end
end
