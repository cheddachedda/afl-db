class Player < ApplicationRecord
  belongs_to :club, :optional => true
  has_and_belongs_to_many :fixtures
end
