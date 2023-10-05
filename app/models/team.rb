class Team < ApplicationRecord
  validates :name, uniqueness: true
end
