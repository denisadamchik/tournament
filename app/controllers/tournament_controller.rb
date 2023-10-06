class TournamentController < ApplicationController
  include TournamentHelper

  def index
    @stage = params[:stage]

    @games = fetch_games(@stage)
  end

end
