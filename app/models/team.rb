class Team < ApplicationRecord
  enum division: {
    "A" => 0,
    "B" => 1
  }

  validates :name, uniqueness: true
  validates :division, inclusion: divisions.keys
  validates :points, numericality: { greater_than_or_equal_to: 0 }

  scope :active, -> { where(active: true) }
  scope :a, -> { where(division: "A") }
  scope :b, -> { where(division: "B") }

  def games
    Game.where("home_team_id = ? OR away_team_id = ?", id, id)
  end
end
