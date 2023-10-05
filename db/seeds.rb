# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

GameResult.delete_all
Game.delete_all
Division.delete_all
Team.delete_all

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

teams.each { Team.create!(name: _1) }

division_a = Division.create!(title: "A")
division_b = Division.create!(title: "B")

Team.order('RANDOM()').limit(8).each do |team|
  division_a.teams << team
  division_a.save!
end

Team.where.missing(:division).each do |team|
  division_b.teams << team
  division_b.save!
end
