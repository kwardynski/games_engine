defmodule GamesEngine.Grid.Point do
  @moduledoc """
  Point component - represents a point in space
  """
  alias GamesEngine.Validations.NumericValidations

  @type t :: %__MODULE__{}

  @enforce_keys [:x, :y]
  defstruct x: 0, y: 0

  @doc """
  Creates a new `%Point{}` struct
  """
  @spec new(number(), number()) :: t() | {:error, String.t()}
  def new(x, y) do
    with(
      :ok <- NumericValidations.non_neg_integer(x),
      :ok <- NumericValidations.non_neg_integer(y)
    ) do
      %__MODULE__{x: x, y: y}
    end
  end
end
