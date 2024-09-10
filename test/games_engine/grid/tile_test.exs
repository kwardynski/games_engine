defmodule GamesEngine.Grid.TileTest do
  use ExUnit.Case, async: true

  alias GamesEngine.Grid.Coordinate
  alias GamesEngine.Grid.Tile

  describe "new/1" do
    test "returns error tuple if row is not a positive integer" do
      assert {:error, _} = Tile.new({-3, 3})
    end

    test "returns error tuple if col is not a positive integer" do
      assert {:error, _} = Tile.new({3, -3})
    end

    test "returns %Tile{} struct if row/col values are valid" do
      assert %Tile{coordinate: %Coordinate{row: 3, col: 3}} = Tile.new({3, 3})
    end
  end

  describe "replace_attributes/2" do
    setup do
      [
        tile: %Tile{
          coordinate: nil,
          attributes: %{}
        }
      ]
    end

    test "returns error tuple if new attributes arg is not a map", %{tile: tile} do
      assert {:error, "expected map for :attributes"} = Tile.replace_attributes(tile, "not a map")
    end

    test "successfully replaces the attributes of a tile", %{tile: tile} do
      new_attributes = %{a: 1, b: 2}
      assert %Tile{attributes: ^new_attributes} = Tile.replace_attributes(tile, new_attributes)
    end
  end

  describe "update_attribute/3" do
    setup do
      [
        tile: %Tile{
          coordinate: nil,
          attributes: %{a: 1}
        }
      ]
    end

    test "returns tile with existing attributes if new attribute supplied", %{tile: tile} do
      assert tile == Tile.update_attribute(tile, :new_key, 2)
    end

    test "successfully updates an existing attribute", %{tile: tile} do
      assert %Tile{attributes: %{a: 2}} = Tile.update_attribute(tile, :a, 2)
    end
  end

  describe "add_attribute/3" do
    setup do
      [
        tile: %Tile{
          coordinate: nil,
          attributes: %{a: 1}
        }
      ]
    end

    test "returns tile with existing attributes if existing attribute supplied", %{tile: tile} do
      assert tile == Tile.add_attribute(tile, :a, 3)
    end

    test "successfully adds a new attribute", %{tile: tile} do
      assert %Tile{attributes: %{a: 1, b: 2}} = Tile.add_attribute(tile, :b, 2)
    end
  end
end
