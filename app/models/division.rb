class Division < ApplicationRecord
  enum title: {
    "A" => 0, 
    "B" => 1
  }

  has_many :teams, dependent: :nullify

  validates :title, inclusion: titles.keys, uniqueness: true

  def process = couples.each { Game.play(_1, level:) }

  private

  def couples
    active_teams = teams.active.order(points: :desc, name: :asc)
    best_team, worst_team = active_teams.first, active_teams.last

    active_teams.excluding(best_team, worst_team).each_slice(2).to_a << [best_team, worst_team]
  end

  def games = Game.where(home_team: teams).or(Game.where(away_team: teams))

  def level = games.order(:level).last.level
end
