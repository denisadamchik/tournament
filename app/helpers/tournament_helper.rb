module TournamentHelper
  STAGES = %w[
    regular
    playoff
    semifinal
    final
  ].freeze

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

  private

  def _next(stage)
    index = STAGES.index(stage)
    STAGES[index + 1]
  end

  def _prev(stage)
    index = STAGES.index(stage)
    index == 0 ? nil : STAGES[index - 1]
  end
end
