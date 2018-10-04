# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PartidoService.Repo.insert!(%PartidoService.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias PartidoService.Repo
alias PartidoService.Service.Partido
for _ <- 1..10 do
  id = [1, 2, 3, 4, 5, 6]
  local = Enum.random(id)
  id = List.delete(id, local)
  away = Enum.random(id)
  Repo.insert!(%Partido{
    cancha_id: Enum.random(1..5),
    fecha: NaiveDateTime.utc_now,
    equipo_local_id: local,
    equipo_visitante_id: away
})
end

for _ <- 1..5 do
  id = [1, 2, 3, 4, 5, 6]
  local = Enum.random(id)
  id = List.delete(id, local)
  away = Enum.random(id)
  Repo.insert!(%Partido{
    cancha_id: Enum.random(1..5),
    fecha: NaiveDateTime.utc_now,
    equipo_local_id: local,
    equipo_visitante_id: away,
    jugado: true,
    marcador_local: Enum.random(0..3),
    marcador_visitante: Enum.random(0..3)
})
end
