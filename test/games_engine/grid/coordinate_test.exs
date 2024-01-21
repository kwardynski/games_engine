defmodule GamesEngine.Grid.CoordinateTest do
  use ExUnit.Case, async: true

  alias GamesEngine.Grid.Coordinate

  describe "ind2sub/3" do
    test "returns error tuple if ind is not a positive integer" do
      assert {:error, _} = Coordinate.ind2sub(-12, 3, 3)
    end

    test "returns error tuple if row is not a positive integer" do
      assert {:error, _} = Coordinate.ind2sub(3, -1, 3)
    end

    test "returns error tuple if col is not a positive integer" do
      assert {:error, _} = Coordinate.ind2sub(3, 1, -3)
    end

    test "returns error tuple if ind exceeds bounds of grid" do
      assert {:error, _} = Coordinate.ind2sub(9, 2, 2)
    end

    test "correctly converts ind to subs" do
      assert {2, 1} == Coordinate.ind2sub(5, 3, 3)
      assert {0, 2} == Coordinate.ind2sub(4, 2, 3)
      assert {1, 1} == Coordinate.ind2sub(4, 3, 2)
    end
  end

  describe "sub2ind/3" do
    test "returns error tuple if row is not a positive integer" do
      assert {:error, _} = Coordinate.sub2ind({-1, 2}, 3, 3)
    end

    test "returns error tuple if col is not a positive integer" do
      assert {:error, _} = Coordinate.sub2ind({1, -2}, 3, 3)
    end

    test "returns error tuple if rows is not a positive integer" do
      assert {:error, _} = Coordinate.sub2ind({1, 2}, -3, 3)
    end

    test "returns error tuple if cols is not a positive integer" do
      assert {:error, _} = Coordinate.sub2ind({1, 2}, 3, -3)
    end

    test "correctly converts row/col sub to linear index" do
      assert 5 == Coordinate.sub2ind({2, 1}, 3, 3)
      assert 4 == Coordinate.sub2ind({0, 2}, 2, 3)
      assert 4 == Coordinate.sub2ind({1, 1}, 3, 2)
    end
  end
end
