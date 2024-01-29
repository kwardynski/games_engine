defmodule GamesEngine.GridFixtures do
  @moduledoc """
  This module defines test helpers for creating grid entities
  """

  alias GamesEngine.Grid

  @doc """
  Generate a grid
  """
  def grid_fixture(rows, cols, tile_attributes \\ %{}) do
    Grid.new(rows, cols)
    |> Grid.populate(tile_attributes)
  end
end
