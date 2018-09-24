defmodule PartidoServiceWeb.PartidoControllerTest do
  use PartidoServiceWeb.ConnCase

  alias PartidoService.Service
  alias PartidoService.Service.Partido

  @create_attrs %{cancha_id: 42, equipo_local_id: 42, equipo_visitante_id: 42, fecha: ~D[2010-04-17], jugado: true, marcador_local: 42, marcador_visitante: 42}
  @update_attrs %{cancha_id: 43, equipo_local_id: 43, equipo_visitante_id: 43, fecha: ~D[2011-05-18], jugado: false, marcador_local: 43, marcador_visitante: 43}
  @invalid_attrs %{cancha_id: nil, equipo_local_id: nil, equipo_visitante_id: nil, fecha: nil, jugado: nil, marcador_local: nil, marcador_visitante: nil}

  def fixture(:partido) do
    {:ok, partido} = Service.create_partido(@create_attrs)
    partido
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all partidos", %{conn: conn} do
      conn = get conn, partido_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create partido" do
    test "renders partido when data is valid", %{conn: conn} do
      conn = post conn, partido_path(conn, :create), partido: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, partido_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "cancha_id" => 42,
        "equipo_local_id" => 42,
        "equipo_visitante_id" => 42,
        "fecha" => "2010-04-17",
        "jugado" => true,
        "marcador_local" => 42,
        "marcador_visitante" => 42}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, partido_path(conn, :create), partido: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update partido" do
    setup [:create_partido]

    test "renders partido when data is valid", %{conn: conn, partido: %Partido{id: id} = partido} do
      conn = put conn, partido_path(conn, :update, partido), partido: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, partido_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "cancha_id" => 43,
        "equipo_local_id" => 43,
        "equipo_visitante_id" => 43,
        "fecha" => "2011-05-18",
        "jugado" => false,
        "marcador_local" => 43,
        "marcador_visitante" => 43}
    end

    test "renders errors when data is invalid", %{conn: conn, partido: partido} do
      conn = put conn, partido_path(conn, :update, partido), partido: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete partido" do
    setup [:create_partido]

    test "deletes chosen partido", %{conn: conn, partido: partido} do
      conn = delete conn, partido_path(conn, :delete, partido)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, partido_path(conn, :show, partido)
      end
    end
  end

  defp create_partido(_) do
    partido = fixture(:partido)
    {:ok, partido: partido}
  end
end
