module FixturesHelper
  def get_all_rounds
    Fixture.pluck(:round_id).uniq
  end
end
