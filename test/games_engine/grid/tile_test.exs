defmodule GamesEngine.Grid.TileTest do
  use ExUnit.Case, async: true

  alias GamesEngine.Grid.Coordinate
  alias GamesEngine.Grid.Tile

  describe "new/1" do
    test "returns error tuple if row is not a positive integer" do
      assert {:error, _} = Tile.new({-3, 3})
    end

    test "returns error tuple ic fol is not a positive integer" do
      assert {:error, _} = Tile.new({3, -3})
    end

    test "returns %Tile{} struct if row/col values are valid" do
      assert %Tile{coordinate: %Coordinate{row: 3, col: 3}} = Tile.new({3, 3})
    end
  end
end
