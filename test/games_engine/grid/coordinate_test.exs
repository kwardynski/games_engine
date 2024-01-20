defmodule GamesEngine.Grid.CoordinateTest do
  use ExUnit.Case, async: true

  alias GamesEngine.Grid.Coordinate

  describe "ind2sub/2" do
    test "returns error tuple if ind is not a positive integer" do
      assert {:error, _} = Coordinate.ind2sub(-12, {3, 3})
    end

    test "returns error tuple if row is not a positive integer" do
      assert {:error, _} = Coordinate.ind2sub(3, {-1, 3})
    end

    test "returns error tuple if col is not a positive integer" do
      assert {:error, _} = Coordinate.ind2sub(3, {1, -3})
    end

    test "returns error tuple if ind exceeds bounds of grid" do
      assert {:error, _} = Coordinate.ind2sub(9, {2, 2})
    end

    test "correctly converts ind to subs" do
      assert %Coordinate{row: 2, col: 1} == Coordinate.ind2sub(5, {3, 3})
      assert %Coordinate{row: 0, col: 2} == Coordinate.ind2sub(4, {2, 3})
      assert %Coordinate{row: 1, col: 1} == Coordinate.ind2sub(4, {3, 2})
    end
  end
end
