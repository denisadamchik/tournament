class Team < ApplicationRecord
  include Divisionable

  validates :name, uniqueness: true
  validates :points, numericality: { greater_than_or_equal_to: 0 }

  scope :active, -> { where(active: true) }
  scope :a, -> { where(division: "A") }
  scope :b, -> { where(division: "B") }

  def games
    Game.where("home_team_id = ? OR away_team_id = ?", id, id)
  end
end
