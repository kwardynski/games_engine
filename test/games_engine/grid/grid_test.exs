defmodule GamesEngine.Grid.GridTest do
  use ExUnit.Case, async: true

  alias GamesEngine.Grid.Grid

  describe "new/2" do
    test "returns error tuple if row is not a positive integer" do
      assert {:error, _} = Grid.new(-3, 3)
    end

    test "returns error if col is not a positive integer" do
      assert {:error, _} = Grid.new(3, -3)
    end

    test "returns %Coordinate{} struct if row/col values valid" do
      assert %Grid{rows: 3, cols: 3, coordinates: nil} == Grid.new(3, 3)
    end
  end

  describe "populate/2" do
    test "successfully populates the :coordinates for a %Grid{}" do
      grid = Grid.new(2, 2)

      num_coordinates =
        grid
        |> Grid.populate()
        |> Map.get(:coordinates)
        |> Map.keys()
        |> length()

      assert num_coordinates == 4
    end
  end
end
