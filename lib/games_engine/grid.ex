defmodule GamesEngine.Grid do
  @moduledoc """
  Grid component - represents a collection of Coordinates
  """

  alias GamesEngine.Grid.Coordinate
  alias GamesEngine.Validations.NumericValidations

  @type t :: %__MODULE__{}

  @enforce_keys [:rows, :cols]
  defstruct rows: 0, cols: 0, coordinates: %{}

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
  Populates a `%Grid{}` with `%Coordinates{}`
  """
  @spec populate(t()) :: t()
  def populate(%__MODULE__{rows: rows, cols: cols} = grid)
      when not is_nil(rows) and not is_nil(cols) do
    coordinates = generate_coordinates(rows, cols)
    %{grid | coordinates: coordinates}
  end

  @spec generate_coordinates(non_neg_integer(), non_neg_integer()) :: %{
          non_neg_integer() => Coordinate.t()
        }
  defp generate_coordinates(rows, cols) do
    max_ind = rows * cols - 1

    Enum.reduce(0..max_ind, %{}, fn ind, coordinates ->
      {row, col} = Coordinate.ind2sub(ind, rows, cols)
      coordinate = Coordinate.new({row, col})
      Map.put(coordinates, ind, coordinate)
    end)
  end
end
