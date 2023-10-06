class TournamentController < ApplicationController
  include TournamentHelper

  def index
    @stage = params[:stage]
  end

end
