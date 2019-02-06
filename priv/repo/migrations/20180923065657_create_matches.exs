defmodule MatchService.Repo.Migrations.CreateMatches do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :court_id, :integer
      add :date, :naive_datetime
      add :played, :boolean, default: false, null: false
      add :team_home_id, :string
      add :team_away_id, :string
      add :score_home, :integer
      add :score_away, :integer

      timestamps()
    end

  end
end
