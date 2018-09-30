defmodule PartidoService.Repo.Migrations.CreatePartidos do
  use Ecto.Migration

  def change do
    create table(:partidos) do
      add :cancha_id, :integer
      add :fecha, :naive_datetime
      add :jugado, :boolean, default: false, null: false
      add :equipo_local_id, :integer
      add :equipo_visitante_id, :integer
      add :marcador_local, :integer
      add :marcador_visitante, :integer

      timestamps()
    end

  end
end
