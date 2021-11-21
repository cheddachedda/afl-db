class GameLog < ApplicationRecord
  belongs_to :player
  belongs_to :fixture
  belongs_to :club
end
