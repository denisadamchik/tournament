module TournamentHelper
  def links(stage)
    prev_link = if (prev_stage = _prev(stage))
      link_to prev_stage.capitalize, tournament_index_path(stage: prev_stage)
    else
      link_to "Teams", teams_index_path
    end

    next_link = if (next_stage = _next(stage))
      link_to next_stage.capitalize, tournament_index_path(stage: next_stage)
    end

    next_link.present? ? safe_join([prev_link, next_link], "|") : prev_link
  end

  def fetch_games(stage)
    games = Game.where(stage:)
    return games if games.present?

    couples(stage).each { Game.play(_1, stage:) }
    Game.where(stage:)
  end

  private

  def couples(stage)
    return [[Team.a.active.take, Team.b.active.take]] if stage == "final"

    couples = []

    [Team.a, Team.b].each do |teams|
      active_teams = teams.active.order(points: :desc, name: :asc)
      best_team, worst_team = active_teams.first, active_teams.last
      couples << [best_team, worst_team]
      couples += active_teams.excluding(best_team, worst_team).each_slice(2).to_a
    end

    couples
  end

  def _next(stage)
    index = Game.stages.keys.index(stage)
    Game.stages.keys[index + 1]
  end

  def _prev(stage)
    index = Game.stages.keys.index(stage)
    index == 0 ? nil : Game.stages.keys[index - 1]
  end
end
