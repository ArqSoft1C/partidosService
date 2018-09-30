defmodule PartidoService.ServiceTest do
  use PartidoService.DataCase

  alias PartidoService.Service

  describe "partidos" do
    alias PartidoService.Service.Partido

    @valid_attrs %{cancha_id: 42, equipo_local_id: 42, equipo_visitante_id: 42, fecha: ~D[2010-04-17], jugado: true, marcador_local: 42, marcador_visitante: 42}
    @update_attrs %{cancha_id: 43, equipo_local_id: 43, equipo_visitante_id: 43, fecha: ~D[2011-05-18], jugado: false, marcador_local: 43, marcador_visitante: 43}
    @invalid_attrs %{cancha_id: nil, equipo_local_id: nil, equipo_visitante_id: nil, fecha: nil, jugado: nil, marcador_local: nil, marcador_visitante: nil}

    def partido_fixture(attrs \\ %{}) do
      {:ok, partido} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Service.create_partido()

      partido
    end

    test "list_partidos/0 returns all partidos" do
      partido = partido_fixture()
      assert Service.list_partidos() == [partido]
    end

    test "get_partido!/1 returns the partido with given id" do
      partido = partido_fixture()
      assert Service.get_partido!(partido.id) == partido
    end

    test "create_partido/1 with valid data creates a partido" do
      assert {:ok, %Partido{} = partido} = Service.create_partido(@valid_attrs)
      assert partido.cancha_id == 42
      assert partido.equipo_local_id == 42
      assert partido.equipo_visitante_id == 42
      assert partido.fecha == ~D[2010-04-17]
      assert partido.jugado == true
      assert partido.marcador_local == 42
      assert partido.marcador_visitante == 42
    end

    test "create_partido/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Service.create_partido(@invalid_attrs)
    end

    test "update_partido/2 with valid data updates the partido" do
      partido = partido_fixture()
      assert {:ok, partido} = Service.update_partido(partido, @update_attrs)
      assert %Partido{} = partido
      assert partido.cancha_id == 43
      assert partido.equipo_local_id == 43
      assert partido.equipo_visitante_id == 43
      assert partido.fecha == ~D[2011-05-18]
      assert partido.jugado == false
      assert partido.marcador_local == 43
      assert partido.marcador_visitante == 43
    end

    test "update_partido/2 with invalid data returns error changeset" do
      partido = partido_fixture()
      assert {:error, %Ecto.Changeset{}} = Service.update_partido(partido, @invalid_attrs)
      assert partido == Service.get_partido!(partido.id)
    end

    test "delete_partido/1 deletes the partido" do
      partido = partido_fixture()
      assert {:ok, %Partido{}} = Service.delete_partido(partido)
      assert_raise Ecto.NoResultsError, fn -> Service.get_partido!(partido.id) end
    end

    test "change_partido/1 returns a partido changeset" do
      partido = partido_fixture()
      assert %Ecto.Changeset{} = Service.change_partido(partido)
    end
  end
end
