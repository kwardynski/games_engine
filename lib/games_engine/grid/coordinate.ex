defmodule GamesEngine.Grid.Coordinate do
  @moduledoc """
  Functions for handling coordinate transformations and translations
  """

  alias GamesEngine.Validations.GridValidations
  alias GamesEngine.Validations.NumericValidations

  @type t :: %__MODULE__{}

  @enforce_keys [:row, :col]
  defstruct row: nil, col: nil

  @doc """
  Converts a coordinate's linear index to row/col subscript

  | 0 | 3 | 6 |     |0,0|0,1|0,2|
  | 1 | 4 | 7 | --> |1,0|1,1|1,2|
  | 2 | 5 | 8 |     |2,0|2,1|2,2|
  """
  @spec ind_2_sub(non_neg_integer(), {non_neg_integer(), non_neg_integer()}) :: t(),
        {:error, String.t()}
  def ind_2_sub(ind, {rows, cols}) do
    with(
      :ok <- NumericValidations.non_neg_integer(ind),
      :ok <- NumericValidations.non_neg_integer(rows),
      :ok <- NumericValidations.non_neg_integer(cols),
      :ok <- GridValidations.ind_within_bounds(ind, {rows, cols})
    ) do
      row = rem(ind, rows)
      col = floor(ind / rows)

      %__MODULE__{row: row, col: col}
    end
  end
end
