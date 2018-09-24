defmodule PartidoServiceWeb.PartidoController do
  use PartidoServiceWeb, :controller

  alias PartidoService.Service
  alias PartidoService.Service.Partido

  action_fallback PartidoServiceWeb.FallbackController

  def index(conn, _params) do
    partidos = Service.list_partidos()
    render(conn, "index.json", partidos: partidos)
  end

  def create(conn, %{"partido" => partido_params}) do
    with {:ok, %Partido{} = partido} <- Service.create_partido(partido_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", partido_path(conn, :show, partido))
      |> render("show.json", partido: partido)
    end
  end

  def show(conn, %{"id" => id}) do
    partido = Service.get_partido!(id)
    render(conn, "show.json", partido: partido)
  end

  def update(conn, %{"id" => id, "partido" => partido_params}) do
    partido = Service.get_partido!(id)

    with {:ok, %Partido{} = partido} <- Service.update_partido(partido, partido_params) do
      render(conn, "show.json", partido: partido)
    end
  end

  def delete(conn, %{"id" => id}) do
    partido = Service.get_partido!(id)
    with {:ok, %Partido{}} <- Service.delete_partido(partido) do
      send_resp(conn, :no_content, "")
    end
  end
end
