class Club < ApplicationRecord
  has_and_belongs_to_many :fixtures
  has_many :players
end
