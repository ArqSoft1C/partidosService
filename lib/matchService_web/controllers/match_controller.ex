defmodule MatchServiceWeb.MatchController do
  use MatchServiceWeb, :controller

  alias MatchService.Service
  alias MatchService.Service.Match

  action_fallback MatchServiceWeb.FallbackController

  def index(conn, _params) do
    matches = Service.list_matches()
    render(conn, "index.json", matches: matches)
  end

  def create(conn, %{"match" => match_params}) do
    with {:ok, %Match{} = match} <- Service.create_match(match_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", match_path(conn, :show, match))
      |> render("show.json", match: match)
    end
  end

  def show(conn, %{"id" => id}) do
    match = Service.get_match!(id)
    render(conn, "show.json", match: match)
  end

  def update(conn, %{"id" => id, "match" => match_params}) do
    match = Service.get_match!(id)

    with {:ok, %Match{} = match} <- Service.update_match(match, match_params) do
      render(conn, "show.json", match: match)
    end
  end

  def updateScore(conn, %{"id" => id, "match" => match_params}) do
    match = Service.get_match!(id)
    with {:ok, %Match{} = match} <- Service.update_score_match(match, match_params) do
      render(conn, "show.json", match: match)
    end
  end

  def getByEquipo(conn, %{"team_id" => team_id}) do
    matches = Service.get_match_by_team(team_id)
    render(conn, "index.json", matches: matches)
  end

  def getJugados(conn, _params) do
    matches = Service.get_played()
    render(conn, "index.json", matches: matches)
  end

  def delete(conn, %{"id" => id}) do
    match = Service.get_match!(id)
    with {:ok, %Match{}} <- Service.delete_match(match) do
      send_resp(conn, :no_content, "")
    end
  end
end
