defmodule GamesEngine.Validations.GridValidations do
  @moduledoc """
  Functions with perform validations of a game grid
  """

  alias GamesEngine.Grid
  alias GamesEngine.Grid.Point

  @type point_within_bounds_errors :: %{
          top: boolean(),
          bottom: boolean(),
          left: boolean(),
          right: boolean()
        }

  @doc """
  Ensures a linear index is within the bounds of the supplied grid
  """
  @spec ind_within_bounds(non_neg_integer(), Grid.t()) :: :ok, {:error, String.t()}
  def ind_within_bounds(ind, %Grid{} = grid) do
    ind_within_bounds(ind, grid.rows, grid.cols)
  end

  @spec ind_within_bounds(non_neg_integer(), non_neg_integer(), non_neg_integer()) :: :ok,
        {:error, String.t()}
  def ind_within_bounds(ind, rows, cols) do
    if ind >= rows * cols,
      do: {:error, "#{ind} exceeds the bounds of a #{rows}x#{cols} board"},
      else: :ok
  end

  @doc """
  Ensures a row/col subscript is within the bounds of the supplied grid
  """
  @spec sub_within_bounds({non_neg_integer(), non_neg_integer()}, Grid.t()) ::
          :ok | {:error, String.t()}
  def sub_within_bounds({row, col}, %Grid{} = grid) do
    sub_within_bounds({row, col}, grid.rows, grid.cols)
  end

  @spec sub_within_bounds(
          {non_neg_integer(), non_neg_integer()},
          non_neg_integer(),
          non_neg_integer()
        ) :: :ok | {:error, String.t()}
  def sub_within_bounds({row, col}, rows, cols) do
    if row < rows && col < cols,
      do: :ok,
      else: {:error, "(#{row}, #{col}) exceeds the bounds of a #{rows}x#{cols} board"}
  end

  @doc """
  Determines whether a `%Point{}` is within the bounds of a `%Grid{}.
  If the `%Point{}`'s coordinates are outside the `%Grid{}`, will return an error tuple
  along with the direction(s) which the `%Point{}` is outside the `%Grid{}`

  ## Examples

      iex> grid = %GamesEngine.Grid{rows: 10, cols: 10}
      iex> point = %GamesEngine.Grid.Point{x: 3, y: 5.4}
      iex> GamesEngine.Validations.GridValidations.point_within_bounds(point, grid)
      :ok

      iex> grid = %GamesEngine.Grid{rows: 10, cols: 10}
      iex> point = %GamesEngine.Grid.Point{x: 12, y: -7.3}
      iex> GamesEngine.Validations.GridValidations.point_within_bounds(point, grid)
      {:error, %{top: true, bottom: false, right: true, left: false}}

  """
  @spec point_within_bounds(Point.t(), Grid.t()) :: :ok, {:error, point_within_bounds()}
  def point_within_bounds(%Point{} = point, %Grid{} = grid) do
    errors = %{
      top: false,
      bottom: false,
      left: false,
      right: false
    }

    errors =
      errors
      |> check_if_outside_top(point, grid)
      |> check_if_outside_bottom(point, grid)
      |> check_if_outside_left(point, grid)
      |> check_if_outside_right(point, grid)

    if Enum.any?(errors, fn {_dir, outside_bounds?} -> outside_bounds? end),
      do: {:error, errors},
      else: :ok
  end

  defp check_if_outside_top(errors, %Point{y: y}, _grid) when y < 0, do: %{errors | top: true}
  defp check_if_outside_top(errors, _point, _grid), do: errors

  defp check_if_outside_bottom(errors, %Point{y: y}, %Grid{rows: rows}) when y > rows, do: %{errors | bottom: true}
  defp check_if_outside_bottom(errors, _point, _grid), do: errors

  defp check_if_outside_left(errors, %Point{x: x}, _grid) when x < 0, do: %{errors | left: true}
  defp check_if_outside_left(errors, _pont, _grid), do: errors

  defp check_if_outside_right(errors, %Point{x: x}, %Grid{cols: cols}) when x > cols, do: %{errors | right: true}
  defp check_if_outside_right(errors, _pont, _grid), do: errors
end
