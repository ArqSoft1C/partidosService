defmodule MatchService.Service.Match do
  use Ecto.Schema
  import Ecto.Changeset


  schema "matches" do
    field :court_id, :integer
    field :team_home_id, :integer
    field :team_away_id, :integer
    field :date, :naive_datetime
    field :played, :boolean, default: false
    field :score_home, :integer, default: 0
    field :score_away, :integer, default: 0

    timestamps()
  end

  @doc false
  def changeset(match, attrs) do
    match
    |> cast(attrs, [:court_id, :date, :team_home_id, :team_away_id, :score_home, :score_away, :played])
    |> validate_required([:court_id, :date, :team_home_id, :team_away_id])
  end

  @doc false
  def changesetScores(match, attrs) do
    match
    |> cast(attrs, [:score_home, :score_away])
    |> cast(%{played: true}, [:played])
    |> validate_required([:played, :score_home, :score_away])
  end
end
