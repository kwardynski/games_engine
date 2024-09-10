defmodule GamesEngine.GridTest do
  use ExUnit.Case, async: true

  import GamesEngine.GridFixtures

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

  describe "replace_tile_attributes/3" do
    test "returns error tuple if new attributes arg is not a map" do
      grid = grid_fixture(3, 3)
      assert {:error, "expected map for :attributes"} = Grid.replace_tile_attributes(grid, 3, "invalid_input")
    end

    test "successfully replaces the attributes of a tile" do
      grid = grid_fixture(3, 3)
      attributes = %{key: "value"}

      assert %Grid{tiles: %{3 => %{attributes: replaced_tile_attributes}}} =
               Grid.replace_tile_attributes(grid, 3, attributes)

      assert replaced_tile_attributes == attributes
    end
  end

  describe "update_tile_attribute/4" do
    test "no change to tile attributes if a new attribute is supplied" do
      attributes = %{key: "value"}
      grid = grid_fixture(3, 3, attributes)

      assert %Grid{tiles: %{3 => %{attributes: tile_attributes}}} =
               Grid.update_tile_attribute(grid, 3, :new_key, "new_value")

      assert tile_attributes == attributes
    end

    test "successfully updates an existing tile attribute" do
      attributes = %{key: "value"}
      grid = grid_fixture(3, 3, attributes)

      assert %Grid{tiles: %{3 => %{attributes: updated_tile_attributes}}} =
               Grid.update_tile_attribute(grid, 3, :key, "new_value")

      assert updated_tile_attributes == %{key: "new_value"}
    end
  end

  describe "add_tile_attribute/4" do
    test "no change to tile attributes if a existing attribute is supplied" do
      attributes = %{key: "value"}
      grid = grid_fixture(3, 3, attributes)

      assert %Grid{tiles: %{3 => %{attributes: tile_attributes}}} =
               Grid.add_tile_attribute(grid, 3, :key, "new_value")

      assert tile_attributes == attributes
    end

    test "successfully adds a new attribute to the tile" do
      attributes = %{key: "value"}
      grid = grid_fixture(3, 3, attributes)

      assert %Grid{tiles: %{3 => %{attributes: updated_tile_attributes}}} =
               Grid.add_tile_attribute(grid, 3, :new_key, "new_value")

      assert updated_tile_attributes == %{key: "value", new_key: "new_value"}
    end
  end
end
