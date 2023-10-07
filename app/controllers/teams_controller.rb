class TeamsController < ApplicationController
  before_action :reset

  def index
    @teams = Team.all
  end

  private

  def reset
    if params[:reset]
      Game.delete_all
      Team.update_all(active: true, points: 0)
    end
  end

end
