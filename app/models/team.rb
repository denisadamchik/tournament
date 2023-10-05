class Team < ApplicationRecord
  belongs_to :division, optional: true

  validates :name, uniqueness: true

  def games
    Game.where("home_team_id = ? OR away_team_id = ?", id, id)
  end
end
