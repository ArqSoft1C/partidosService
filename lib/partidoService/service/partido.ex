defmodule PartidoService.Service.Partido do
  use Ecto.Schema
  import Ecto.Changeset


  schema "partidos" do
    field :cancha_id, :integer
    field :equipo_local_id, :integer
    field :equipo_visitante_id, :integer
    field :fecha, :date
    field :jugado, :boolean, default: false
    field :marcador_local, :integer
    field :marcador_visitante, :integer

    timestamps()
  end

  @doc false
  def changeset(partido, attrs) do
    partido
    |> cast(attrs, [:cancha_id, :fecha, :jugado, :equipo_local_id, :equipo_visitante_id, :marcador_local, :marcador_visitante])
    |> validate_required([:cancha_id, :fecha, :jugado, :equipo_local_id, :equipo_visitante_id, :marcador_local, :marcador_visitante])
  end
end
