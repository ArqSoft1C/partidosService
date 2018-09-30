defmodule PartidoServiceWeb.PartidoView do
  use PartidoServiceWeb, :view
  alias PartidoServiceWeb.PartidoView

  def render("index.json", %{partidos: partidos}) do
    %{data: render_many(partidos, PartidoView, "partido.json")}
  end

  def render("show.json", %{partido: partido}) do
    %{data: render_one(partido, PartidoView, "partido.json")}
  end

  def render("partido.json", %{partido: partido}) do
    %{id: partido.id,
      cancha_id: partido.cancha_id,
      fecha: partido.fecha,
      jugado: partido.jugado,
      equipo_local_id: partido.equipo_local_id,
      equipo_visitante_id: partido.equipo_visitante_id,
      marcador_local: partido.marcador_local,
      marcador_visitante: partido.marcador_visitante}
  end
end
