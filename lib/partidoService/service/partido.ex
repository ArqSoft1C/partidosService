defmodule PartidoService.Service.Partido do
  use Ecto.Schema
  import Ecto.Changeset


  schema "partidos" do
    field :cancha_id, :integer
    field :equipo_local_id, :integer
    field :equipo_visitante_id, :integer
    field :fecha, :naive_datetime
    field :jugado, :boolean, default: false
    field :marcador_local, :integer, default: 0
    field :marcador_visitante, :integer, default: 0

    timestamps()
  end

  @doc false
  def changeset(partido, attrs) do
    partido
    |> cast(attrs, [:cancha_id, :fecha, :equipo_local_id, :equipo_visitante_id])
    |> validate_required([:cancha_id, :fecha, :equipo_local_id, :equipo_visitante_id])
  end

  @doc false
  def changesetScores(partido, attrs) do
    partido
    |> cast(attrs, [:marcador_local, :marcador_visitante])
    |> cast(%{jugado: true}, [:jugado])
    |> validate_required([:jugado, :marcador_local, :marcador_visitante])
  end
end
