defmodule GamesEngine.Grid.Coordinate do
  @moduledoc """
  Coordinate Component - represents a square within a grid

  Currently also provides functions for handling coordinate
  transformations.
  """

  alias GamesEngine.Validations.GridValidations
  alias GamesEngine.Validations.NumericValidations

  @type t :: %__MODULE__{}

  @enforce_keys [:row, :col]
  defstruct row: 0, col: 0, attributes: %{}

  @doc """
  Creates a new `%Coordinate{}` struct
  """
  @spec new({non_neg_integer(), non_neg_integer()}) :: t()
  def new({row, col}) do
    with(
      :ok <- NumericValidations.non_neg_integer(row),
      :ok <- NumericValidations.non_neg_integer(col)
    ) do
      %__MODULE__{row: row, col: col}
    end
  end

  @doc """
  Converts a coordinate's linear index to row/col subscript

  | 0 | 3 | 6 |     |0,0|0,1|0,2|
  | 1 | 4 | 7 | --> |1,0|1,1|1,2|
  | 2 | 5 | 8 |     |2,0|2,1|2,2|
  """
  @spec ind2sub(non_neg_integer(), non_neg_integer(), non_neg_integer()) ::
          {non_neg_integer(), non_neg_integer()},
        {:error, String.t()}
  def ind2sub(ind, rows, cols) do
    with(
      :ok <- NumericValidations.non_neg_integer(ind),
      :ok <- NumericValidations.non_neg_integer(rows),
      :ok <- NumericValidations.non_neg_integer(cols),
      :ok <- GridValidations.ind_within_bounds(ind, rows, cols)
    ) do
      row = rem(ind, rows)
      col = floor(ind / rows)

      {row, col}
    end
  end

  @doc """
  Converts a coordinate's row/col subscript into a linear index

  |0,0|0,1|0,2|     | 0 | 3 | 6 |
  |1,0|1,1|1,2| --> | 1 | 4 | 7 |
  |2,0|2,1|2,2|     | 2 | 5 | 8 |
  """
  def sub2ind({row, col}, rows, cols) do
    with(
      :ok <- NumericValidations.non_neg_integer(row),
      :ok <- NumericValidations.non_neg_integer(col),
      :ok <- NumericValidations.non_neg_integer(rows),
      :ok <- NumericValidations.non_neg_integer(cols),
      :ok <- GridValidations.sub_within_bounds({row, col}, rows, cols)
    ) do
      rows * col + row
    end
  end
end
