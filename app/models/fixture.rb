class Fixture < ApplicationRecord
  has_and_belongs_to_many :clubs
  has_and_belongs_to_many :players
end
