defmodule PartidoServiceWeb.Router do
  use PartidoServiceWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PartidoServiceWeb do
    pipe_through :api
    resources "/partidos", PartidoController, except: [:new, :edit]
    put "/partidos_score/:id", PartidoController, :updateScore
    get "/partidos_equipo/:equipo_id", PartidoController, :getByEquipo
    get "/partidos_jugados", PartidoController, :getJugados
  end
end
