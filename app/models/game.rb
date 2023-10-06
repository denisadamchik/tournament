class Game < ApplicationRecord
  enum level: {
    "Division"  => 0, 
    "Play-off"  => 1,
    "Semifinal" => 2,
    "Final"     => 3
  }

  belongs_to :home_team, class_name: 'Team', foreign_key: 'home_team_id'
  belongs_to :away_team, class_name: 'Team', foreign_key: 'away_team_id'

  validates :level, inclusion: levels.keys, presence: true
end
