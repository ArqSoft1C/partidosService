# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     MatchService.Repo.insert!(%MatchService.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias MatchService.Repo
alias MatchService.Service.Match
for _ <- 1..10 do
  id = [1, 2, 3, 4, 5, 6]
  local = Enum.random(id)
  id = List.delete(id, local)
  away = Enum.random(id)
  Repo.insert!(%Match{
    court_id: Enum.random(1..5),
    date: NaiveDateTime.utc_now,
    team_home_id: local,
    team_away_id: away
})
end

for _ <- 1..5 do
  id = [1, 2, 3, 4, 5, 6]
  local = Enum.random(id)
  id = List.delete(id, local)
  away = Enum.random(id)
  Repo.insert!(%Match{
    court_id: Enum.random(1..5),
    date: NaiveDateTime.utc_now,
    team_home_id: local,
    team_away_id: away,
    played: true,
    score_home: Enum.random(0..3),
    score_away: Enum.random(0..3)
})
end
