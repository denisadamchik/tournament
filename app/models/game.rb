class Game < ApplicationRecord
  include Divisionable

  enum stage: {
    "regular"   => 0, 
    "play-off"  => 1,
    "semifinal" => 2,
    "final"     => 3
  }.freeze

  belongs_to :home_team, class_name: "Team", foreign_key: "home_team_id"
  belongs_to :away_team, class_name: "Team", foreign_key: "away_team_id"

  validates :scores, format: { with: %r{\d:\d}, message: "invalid scores" }
  validates :stage, inclusion: stages.keys, presence: true

  scope :a, -> { where(division: "A") }
  scope :b, -> { where(division: "B") }

  def self.play(couple, stage:)
    home_team, away_team = couple.first, couple.second
    home_team_goals, away_team_goals = rand(3), rand(3)

    home_team_points, away_team_points =
      if home_team_goals > away_team_goals
        [3, 0]
      elsif home_team_goals == away_team_goals
        [1, 1]
      else
        [0, 3]
      end

    transaction do
      home_team.points += home_team_points
      away_team.points += away_team_points

      if stage != "regular" && home_team_goals != away_team_goals
        home_team.active = home_team_goals > away_team_goals
        away_team.active = !home_team.active
      end

      home_team.save!
      away_team.save!

      scores = "#{home_team_goals}:#{away_team_goals}"
      division = home_team.division == away_team.division ? home_team.division : nil
      Game.create!(home_team: couple.first, away_team: couple.second, division:, stage:, scores:)
    end
  end
end
