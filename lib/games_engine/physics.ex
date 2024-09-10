defmodule GamesEngine.Physics do
  @moduledoc """
  Physics context
  """
  alias GamesEngine.Grid.Coordinate
  alias GamesEngine.Physics.Velocity

  @doc """
  Calculate's a `%Coordinate{}`'s new position based on a `%Velocity{}`
  """
  def translate(%Coordinate{} = coordinate, %Velocity{} = velocity) do
    new_row = round(coordinate.col + velocity.y)
    new_col = round(coordinate.row + velocity.x)

    %{coordinate | row: new_row, col: new_col}
  end
end
