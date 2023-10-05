class Team < ApplicationRecord
  belongs_to :division, optional: true

  validates :name, uniqueness: true
end
