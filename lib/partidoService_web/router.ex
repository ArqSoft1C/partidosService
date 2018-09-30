defmodule PartidoServiceWeb.Router do
  use PartidoServiceWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PartidoServiceWeb do
    pipe_through :api
    resources "/partidos", PartidoController, except: [:new, :edit]
    put "/partidos/score/:id", PartidoController, :updateScore
    get "/partidos/equipo/:equipo_id", PartidoController, :getByEquipo
  end
end
