defmodule GamesEngine.Validations.NumericValidations do
  @moduledoc """
  Functions which perform numeric validations
  """

  @doc """
  Ensures the input is a non-negative integer
  """
  @spec(non_neg_integer(term()) :: :ok, {:error, String.t()})
  def non_neg_integer(input) when is_integer(input) and input >= 0, do: :ok

  def non_neg_integer(input),
    do: {:error, "Expected non-negative integer, received #{inspect(input)}"}
end
