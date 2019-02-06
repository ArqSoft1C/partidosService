defmodule MatchServiceWeb.MatchControllerTest do
  use MatchServiceWeb.ConnCase

  alias MatchService.Service
  alias MatchService.Service.Match

  @create_attrs %{court_id: 42, team_home_id: 42, team_away_id: 42, date: ~D[2010-04-17], played: true, score_home: 42, score_away: 42}
  @update_attrs %{court_id: 43, team_home_id: 43, team_away_id: 43, date: ~D[2011-05-18], played: false, score_home: 43, score_away: 43}
  @invalid_attrs %{court_id: nil, team_home_id: nil, team_away_id: nil, date: nil, played: nil, score_home: nil, score_away: nil}

  def fixture(:match) do
    {:ok, match} = Service.create_match(@create_attrs)
    match
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all matches", %{conn: conn} do
      conn = get conn, match_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create match" do
    test "renders match when data is valid", %{conn: conn} do
      conn = post conn, match_path(conn, :create), match: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, match_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "court_id" => 42,
        "team_home_id" => 42,
        "team_away_id" => 42,
        "date" => "2010-04-17",
        "played" => true,
        "score_home" => 42,
        "score_away" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, match_path(conn, :create), match: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update match" do
    setup [:create_match]

    test "renders match when data is valid", %{conn: conn, match: %Match{id: id} = match} do
      conn = put conn, match_path(conn, :update, match), match: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, match_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "court_id" => 43,
        "team_home_id" => 43,
        "team_away_id" => 43,
        "date" => "2011-05-18",
        "played" => false,
        "score_home" => 43,
        "score_away" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, match: match} do
      conn = put conn, match_path(conn, :update, match), match: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete match" do
    setup [:create_match]

    test "deletes chosen match", %{conn: conn, match: match} do
      conn = delete conn, match_path(conn, :delete, match)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, match_path(conn, :show, match)
      end
    end
  end

  defp create_match(_) do
    match = fixture(:match)
    {:ok, match: match}
  end
end
