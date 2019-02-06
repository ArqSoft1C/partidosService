defmodule MatchServiceWeb.MatchView do
  use MatchServiceWeb, :view
  alias MatchServiceWeb.MatchView

  def render("index.json", %{matches: matches}) do
    render_many(matches, MatchView, "match.json")
  end

  def render("show.json", %{match: match}) do
    render_one(match, MatchView, "match.json")
  end

  def render("match.json", %{match: match}) do
    %{id: match.id,
      court_id: match.court_id,
      date: match.date,
      played: match.played,
      team_home_id: match.team_home_id,
      team_away_id: match.team_away_id,
      score_home: match.score_home,
      score_away: match.score_away}
  end
end
