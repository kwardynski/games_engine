defmodule GamesEngine.Grid do
  @moduledoc """
  Grid component - represents a collection of Coordinates
  """

  alias GamesEngine.Grid.Coordinate
  alias GamesEngine.Grid.Tile
  alias GamesEngine.Validations.NumericValidations

  @type t :: %__MODULE__{}

  @enforce_keys [:rows, :cols]
  defstruct rows: 0, cols: 0, tiles: %{}

  @doc """
  Creates a new `%Grid{}` struct
  Automatically populates the `:coordinates` attribute with a map of
  `%Coordinate{}`s based on the supplied dimensions
  """
  @spec new(non_neg_integer(), non_neg_integer()) :: t()
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
  @spec populate(t()) :: t()
  def populate(%__MODULE__{rows: rows, cols: cols} = grid) do
    tiles = generate_tiles(rows, cols)
    %{grid | tiles: tiles}
  end

  @spec generate_tiles(non_neg_integer(), non_neg_integer()) :: %{
          non_neg_integer() => Coordinate.t()
        }
  defp generate_tiles(rows, cols) do
    max_ind = rows * cols - 1

    Enum.reduce(0..max_ind, %{}, fn ind, tiles ->
      {row, col} = Coordinate.ind2sub(ind, rows, cols)
      tile = Tile.new({row, col})
      Map.put(tiles, ind, tile)
    end)
  end
end
