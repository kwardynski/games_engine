defmodule GamesEngine.Validations.GridValidations do
  @moduledoc """
  Functions with perform validations of a game grid
  """

  @doc """
  Ensures a linear index is within the bounds of the supplied grid
  """
  @spec ind_within_bounds(non_neg_integer(), {non_neg_integer(), non_neg_integer()}) :: :ok,
        {:error, String.t()}
  def ind_within_bounds(ind, {rows, cols}) do
    if ind >= rows * cols,
      do: {:error, "#{ind} exceeds the bounds of a #{rows}x#{cols} board"},
      else: :ok
  end

  @doc """
  Ensures a row/col subscript is within the bounds of the supplied grid
  """
  @spec sub_within_bounds(
          {non_neg_integer(), non_neg_integer()},
          {non_neg_integer(), non_neg_integer()}
        ) :: :ok | {:error, String.t()}
  def sub_within_bounds({row, col}, {rows, cols}) do
    if row < rows && col < cols,
      do: :ok,
      else: {:error, "(#{row}, #{col}) exceeds the bounds of a #{rows}x#{cols} board"}
  end
end
