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
    horizontal_translation = round(velocity.x)
    vertical_translation = round(velocity.y)

    new_row = coordinate.col + vertical_translation
    new_col = coordinate.row + horizontal_translation

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
