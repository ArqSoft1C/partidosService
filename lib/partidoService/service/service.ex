defmodule PartidoService.Service do
  @moduledoc """
  The Service context.
  """

  import Ecto.Query, warn: false
  alias PartidoService.Repo

  alias PartidoService.Service.Partido

  @doc """
  Returns the list of partidos.

  ## Examples

      iex> list_partidos()
      [%Partido{}, ...]

  """
  def list_partidos do
    Repo.all(Partido)
  end

  @doc """
  Gets a single partido.

  Raises `Ecto.NoResultsError` if the Partido does not exist.

  ## Examples

      iex> get_partido!(123)
      %Partido{}

      iex> get_partido!(456)
      ** (Ecto.NoResultsError)

  """
  def get_partido!(id), do: Repo.get!(Partido, id)

  @doc """
  Creates a partido.

  ## Examples

      iex> create_partido(%{field: value})
      {:ok, %Partido{}}

      iex> create_partido(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_partido(attrs \\ %{}) do
    %Partido{}
    |> Partido.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a partido.

  ## Examples

      iex> update_partido(partido, %{field: new_value})
      {:ok, %Partido{}}

      iex> update_partido(partido, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_partido(%Partido{} = partido, attrs) do
    partido
    |> Partido.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Updates the score of a partido.

  ## Examples

      iex> update_partido(partido, %{field: new_value})
      {:ok, %Partido{}}

      iex> update_partido(partido, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_score_partido(%Partido{} = partido, attrs) do
    partido
    |> Partido.changesetScores(attrs)
    |> Repo.update()
  end


  @doc """
  Deletes a Partido.

  ## Examples

      iex> delete_partido(partido)
      {:ok, %Partido{}}

      iex> delete_partido(partido)
      {:error, %Ecto.Changeset{}}

  """
  def delete_partido(%Partido{} = partido) do
    Repo.delete(partido)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking partido changes.

  ## Examples

      iex> change_partido(partido)
      %Ecto.Changeset{source: %Partido{}}

  """
  def change_partido(%Partido{} = partido) do
    Partido.changeset(partido, %{})
  end

  @doc """
  Returns a list of Partidos given an equipo_id.

  ## Examples

      iex> get_partido_by_equipo!(123)
      [%Partido{}, ...]

  """
  def get_partido_by_equipo(equipo_id) do
    Partido |> where([p], p.equipo_local_id == ^equipo_id or p.equipo_visitante_id == ^equipo_id) |> Repo.all
  end

  @doc """
  Returns a list of Partidos where jugado is true.

  ## Examples

      iex> get_played!()
      [%Partido{}, ...]

  """
  def get_played() do
    Partido |> where([p], p.jugado == true) |> Repo.all
  end
end
