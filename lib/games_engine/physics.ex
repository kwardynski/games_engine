defmodule GamesEngine.Physics do
  @moduledoc """
  Physics context
  """
  alias GamesEngine.Grid.Coordinate
  alias GamesEngine.Physics.Velocity

  @type bounce_type() :: :horizontal | :vertical

  @doc """
  Calculate's a `%Coordinate{}`'s new position based on a `%Velocity{}`
  """
  def translate(%Coordinate{} = coordinate, %Velocity{} = velocity) do
    new_row = round(coordinate.col + velocity.y)
    new_col = round(coordinate.row + velocity.x)

    %{coordinate | row: new_row, col: new_col}
  end

  @doc """
  Returns a `%Velocity{}` with updated speed components after a horizontal
  or vertical bounce

  A :horizontal bounce reflects the `x` component, and a :vertical bounce
  reflects the `y` component
  """
  @spec bounce(Velocity.t(), bounce_type()) :: Velocity.t()
  def bounce(%Velocity{} = velocity, :horizontal), do: %{velocity | x: -velocity.x}
  def bounce(%Velocity{} = velocity, :vertical), do: %{velocity | y: -velocity.y}
end
