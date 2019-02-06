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

ids = [
  "5bb53739573f49000a925f7c",
  "5op53739573f49000a925f7c",
  "5yu53739573f49000a925f7c",
  "5tr53739573f49000a925f7c",
  "5sg53739573f49000a925f7c",
  "5cg53739573f49000a925f7c"
]
for _ <- 1..10 do
  id = ids
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
  id = ids
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
