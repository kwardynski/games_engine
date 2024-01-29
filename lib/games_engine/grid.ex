defmodule GamesEngine.Grid do
  @moduledoc """
  Grid component - represents a collection of Coordinates
  """

  alias GamesEngine.Grid.Coordinate
  alias GamesEngine.Grid.Tile
  alias GamesEngine.Validations.GridValidations
  alias GamesEngine.Validations.NumericValidations

  @type t :: %__MODULE__{}

  @enforce_keys [:rows, :cols]
  defstruct rows: 0, cols: 0, tiles: %{}

  @doc """
  Creates a new `%Grid{}` struct
  Automatically populates the `:coordinates` attribute with a map of
  `%Coordinate{}`s based on the supplied dimensions
  """
  @spec new(non_neg_integer(), non_neg_integer()) :: t() | {:error, String.t()}
  def new(rows, cols) do
    with(
      :ok <- NumericValidations.non_neg_integer(rows),
      :ok <- NumericValidations.non_neg_integer(cols)
    ) do
      %__MODULE__{rows: rows, cols: cols}
    end
  end

  @doc """
  Populates a `%Grid{}` with `%Tile{}`s
  """
  @spec populate(t(), map()) :: t()
  def populate(%__MODULE__{} = grid, attributes \\ %{}) do
    tiles = generate_tiles(grid.rows, grid.cols, attributes)
    %{grid | tiles: tiles}
  end

  @spec generate_tiles(non_neg_integer(), non_neg_integer(), map()) :: %{
          non_neg_integer() => Coordinate.t()
        }
  defp generate_tiles(rows, cols, attributes) do
    max_ind = rows * cols - 1

    Enum.reduce(0..max_ind, %{}, fn ind, tiles ->
      {row, col} = Coordinate.ind2sub(ind, rows, cols)
      tile = Tile.new({row, col}, attributes)
      Map.put(tiles, ind, tile)
    end)
  end

  @doc """
  Replaces the attributes of a tile
  """
  @spec replace_tile_attributes(t(), non_neg_integer(), map()) :: t() | {:error, String.t()}
  def replace_tile_attributes(%__MODULE__{} = grid, ind, attributes) do
    with(
      :ok <- GridValidations.ind_within_bounds(ind, grid),
      {:ok, tiles} <- fetch_grid_tiles(grid),
      %Tile{} = updated_tile <- Tile.replace_attributes(tiles[ind], attributes)
    ) do
      updated_tiles = %{tiles | ind => updated_tile}
      %{grid | tiles: updated_tiles}
    end
  end

  @doc """
  Updates an existing attribute of a `%Tile{}`
  """
  @spec update_tile_attribute(t(), non_neg_integer(), atom(), any()) :: t() | {:error, String.t()}
  def update_tile_attribute(%__MODULE__{} = grid, ind, key, value) do
    with(
      :ok <- GridValidations.ind_within_bounds(ind, grid),
      {:ok, tiles} <- fetch_grid_tiles(grid),
      %Tile{} = updated_tile <- Tile.update_attribute(tiles[ind], key, value)
    ) do
      updated_tiles = %{tiles | ind => updated_tile}
      %{grid | tiles: updated_tiles}
    end
  end

  @doc """
  Adds a new attributes to a `%Tile{}`
  Will not overwrite the attribute if it already exists
  """
  @spec add_tile_attribute(t(), non_neg_integer(), atom(), any()) :: t() | {:error, String.t()}
  def add_tile_attribute(%__MODULE__{} = grid, ind, key, value) do
    with(
      :ok <- GridValidations.ind_within_bounds(ind, grid),
      {:ok, tiles} <- fetch_grid_tiles(grid),
      %Tile{} = updated_tile <- Tile.add_attribute(tiles[ind], key, value)
    ) do
      updated_tiles = %{tiles | ind => updated_tile}
      %{grid | tiles: updated_tiles}
    end
  end

  @spec fetch_grid_tiles(t()) :: {:ok, list(Tile.t())} | {:error, String.t()}
  defp fetch_grid_tiles(grid) do
    tiles = Map.get(grid, :tiles, nil)

    if is_nil(tiles),
      do: {:error, "grid has no tiles"},
      else: {:ok, tiles}
  end
end
