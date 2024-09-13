defmodule GamesEngine.Physics do
  @moduledoc """
  Physics context
  """
  alias GamesEngine.Grid.Coordinate
  alias GamesEngine.Grid.Point
  alias GamesEngine.Physics.Velocity

  @type bounce_type() :: :horizontal | :vertical

  @doc """
  Calculate's a `%Coordinate{}` or `%Point{}`'s new position based on a `%Velocity{}`

  New `row` and `column` attributes will be rounded to conform with `%Grid{}`
  constraints when passed a `%Coordinate{}`

  ## Examples

      iex> coordinate = %GamesEngine.Grid.Coordinate{row: 10, col: 10}
      iex> velocity = %GamesEngine.Physics.Velocity{x: 1, y: -2.5}
      iex> GamesEngine.Physics.translate(coordinate, velocity)
      %GamesEngine.Grid.Coordinate{row: 7, col: 11}

      iex> point = %GamesEngine.Grid.Point{x: 10, y: 10}
      iex> velocity = %GamesEngine.Physics.Velocity{x: 1, y: -2.5}
      iex> GamesEngine.Physics.translate(point, velocity)
      %GamesEngine.Grid.Point{x: 11, y: 7.5}

  """
  def translate(%Coordinate{} = coordinate, %Velocity{} = velocity) do
    horizontal_translation = round(velocity.x)
    vertical_translation = round(velocity.y)

    new_row = coordinate.col + vertical_translation
    new_col = coordinate.row + horizontal_translation

    %{coordinate | row: new_row, col: new_col}
  end

  def translate(%Point{} = point, %Velocity{} = velocity) do
    new_x = point.x + velocity.x
    new_y = point.y + velocity.y

    %{point | x: new_x, y: new_y}
  end

  @doc """
  Returns a `%Velocity{}` with updated speed components after a horizontal
  or vertical bounce

  A :horizontal bounce reflects the `x` component, and a :vertical bounce
  reflects the `y` component

  ## Examples

      iex> velocity = %GamesEngine.Physics.Velocity{x: 5, y: 0}
      iex> GamesEngine.Physics.bounce(velocity, :horizontal)
      %GamesEngine.Physics.Velocity{x: -5, y: 0}

      iex> velocity = %GamesEngine.Physics.Velocity{x: 0, y: -1.2}
      iex> GamesEngine.Physics.bounce(velocity, :vertical)
      %GamesEngine.Physics.Velocity{x: 0, y: 1.2}

  """
  @spec bounce(Velocity.t(), bounce_type()) :: Velocity.t()
  def bounce(%Velocity{} = velocity, :horizontal), do: %{velocity | x: -velocity.x}
  def bounce(%Velocity{} = velocity, :vertical), do: %{velocity | y: -velocity.y}
end
