defmodule MatchService.ServiceTest do
  use MatchService.DataCase

  alias MatchService.Service

  describe "matches" do
    alias MatchService.Service.Match

    @valid_attrs %{court_id: 42, team_home_id: 42, team_away_id: 42, date: ~D[2010-04-17], played: true, score_home: 42, score_away: 42}
    @update_attrs %{court_id: 43, team_home_id: 43, team_away_id: 43, date: ~D[2011-05-18], played: false, score_home: 43, score_away: 43}
    @invalid_attrs %{court_id: nil, team_home_id: nil, team_away_id: nil, date: nil, played: nil, score_home: nil, score_away: nil}

    def match_fixture(attrs \\ %{}) do
      {:ok, match} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Service.create_match()

      match
    end

    test "list_matches/0 returns all matches" do
      match = match_fixture()
      assert Service.list_matches() == [match]
    end

    test "get_match!/1 returns the match with given id" do
      match = match_fixture()
      assert Service.get_match!(match.id) == match
    end

    test "create_match/1 with valid data creates a match" do
      assert {:ok, %Match{} = match} = Service.create_match(@valid_attrs)
      assert match.court_id == 42
      assert match.team_home_id == 42
      assert match.team_away_id == 42
      assert match.date == ~D[2010-04-17]
      assert match.played == true
      assert match.score_home == 42
      assert match.score_away == 42
    end

    test "create_match/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Service.create_match(@invalid_attrs)
    end

    test "update_match/2 with valid data updates the match" do
      match = match_fixture()
      assert {:ok, match} = Service.update_match(match, @update_attrs)
      assert %Match{} = match
      assert match.court_id == 43
      assert match.team_home_id == 43
      assert match.team_away_id == 43
      assert match.date == ~D[2011-05-18]
      assert match.played == false
      assert match.score_home == 43
      assert match.score_away == 43
    end

    test "update_match/2 with invalid data returns error changeset" do
      match = match_fixture()
      assert {:error, %Ecto.Changeset{}} = Service.update_match(match, @invalid_attrs)
      assert match == Service.get_match!(match.id)
    end

    test "delete_match/1 deletes the match" do
      match = match_fixture()
      assert {:ok, %Match{}} = Service.delete_match(match)
      assert_raise Ecto.NoResultsError, fn -> Service.get_match!(match.id) end
    end

    test "change_match/1 returns a match changeset" do
      match = match_fixture()
      assert %Ecto.Changeset{} = Service.change_match(match)
    end
  end
end
