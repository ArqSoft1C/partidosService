defmodule MatchServiceWeb.Router do
  use MatchServiceWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MatchServiceWeb do
    pipe_through :api
    resources "/matches", MatchController, except: [:new, :edit]
    put "/matches_score/:id", MatchController, :updateScore
    get "/matches_team/:team_id", MatchController, :getByEquipo
    get "/matches_played", MatchController, :getJugados
  end
end
