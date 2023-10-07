# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

Team.delete_all
Game.delete_all

teams = [
  "Real Madrid",
  "Barcelona",
  "Manchester United",
  "Bayern Munich",
  "Chelsea",
  "Liverpool",
  "Juventus",
  "Paris Saint Germain",
  "AC Milan",
  "Borussia Dortmund",
  "Manchester City",
  "Arsenal",
  "Inter Milan",
  "Atletico Madrid",
  "Tottenham Hotspur",
  "FC Porto"
]

teams.each_with_index do |team, index|
  division = index.even? ? "A" : "B"
  Team.create!(name: team, division:)
end
