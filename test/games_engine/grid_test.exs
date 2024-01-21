defmodule GamesEngine.GridTest do
  use ExUnit.Case, async: true

  alias GamesEngine.Grid

  describe "new/2" do
    test "returns error tuple if row is not a positive integer" do
      assert {:error, _} = Grid.new(-3, 3)
    end

    test "returns error if col is not a positive integer" do
      assert {:error, _} = Grid.new(3, -3)
    end

    test "returns %Coordinate{} struct if row/col values valid" do
      assert %Grid{rows: 3, cols: 3} == Grid.new(3, 3)
    end
  end

  describe "populate/2" do
    test "successfully populates the :tiles for a %Grid{} with new tiles" do
      grid = Grid.new(2, 2)

      num_tiles =
        grid
        |> Grid.populate()
        |> Map.get(:tiles)
        |> Map.keys()
        |> length()

      assert num_tiles == 4
    end

    test "successfully adds attributes to all tiles" do
      default_attributes = %{value: nil, occupied: false}
      grid = Grid.new(3, 3)

      tiles =
        grid
        |> Grid.populate(default_attributes)
        |> Map.get(:tiles)

      Enum.each(tiles, fn {_, %{attributes: tile_attributes}} ->
        assert tile_attributes == default_attributes
      end)
    end
  end
end
