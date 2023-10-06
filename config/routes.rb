Rails.application.routes.draw do
  root "teams#index", as: "teams_index"

  get "tournament" => "tournament#index", as: "tournament_index"
end
