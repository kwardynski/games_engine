defmodule GamesEngine.Grid.Tile do
  @moduledoc """
  Tile Component
  Representation of a Game Tile on a Grid
  """

  alias GamesEngine.Grid.Coordinate

  @type t :: %__MODULE__{}

  defstruct coordinate: nil, attributes: nil

  @doc """
  Creates a new `%Tile{}` struct
  row/col validation is relegated to the `%Coordinate{}` module
  """
  @spec new({non_neg_integer(), non_neg_integer()}) :: t()
  def new({row, col}) do
    %__MODULE__{coordinate: Coordinate.new({row, col})}
  end

  @spec new({non_neg_integer(), non_neg_integer()}, map()) :: t()
  def new({row, col}, attributes) do
    tile = new({row, col})
    %{tile | attributes: attributes}
  end
end
