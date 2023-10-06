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

    send(stage.underscore)

    Game.where(stage:)
  end

  def regular
    [Team.a, Team.b].each do |teams|
      teams = teams.to_a
      couples = teams.product(teams).reject { _1[0] == _1[1] }.map(&:sort).uniq
      couples.each { Game.play(_1, stage: "regular") }
    end

    [Team.a, Team.b].each do |teams|
      teams.order(points: :desc, name: :asc).last(4).each { _1.update!(active: false) }
    end
  end

  def play_off
    [:a, :b].each do |div|
      while (active_teams = Team.send(div).active).size > 2
        ordered_teams = active_teams.order(points: :desc, name: :asc)
        best_team, worst_team = ordered_teams.first, ordered_teams.last

        Game.play([best_team, worst_team], stage: "play-off")
      end
    end
  end

  def semifinal
    [:a, :b].each do |div|
      while (active_teams = Team.send(div).active).size > 1
        Game.play([active_teams.first, active_teams.last], stage: "semifinal")
      end
    end
  end

  def final
    while (active_teams = Team.active).size > 1
      Game.play([active_teams.first, active_teams.last], stage: "final")
    end
  end

  private

  def _next(stage)
    index = Game.stages.keys.index(stage)
    Game.stages.keys[index + 1]
  end

  def _prev(stage)
    index = Game.stages.keys.index(stage)
    index == 0 ? nil : Game.stages.keys[index - 1]
  end
end
