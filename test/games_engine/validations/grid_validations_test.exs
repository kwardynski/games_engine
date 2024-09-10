defmodule GamesEngine.Validations.GridValidationsTest do
  use ExUnit.Case, async: true

  alias GamesEngine.Grid
  alias GamesEngine.Validations.GridValidations

  describe "ind_within_bounds/2" do
    setup do
      [
        grid: %Grid{rows: 3, cols: 3}
      ]
    end

    test "returns error tuple if ind exceeds bounds of grid", %{grid: grid} do
      assert {:error, "12 exceeds the bounds of a 3x3 board"} = GridValidations.ind_within_bounds(12, grid)
    end

    test "returns :ok if ind within bounds of grid", %{grid: grid} do
      assert :ok == GridValidations.ind_within_bounds(8, grid)
    end
  end

  describe "ind_within_bounds/3" do
    test "returns error tuple if ind exceeds bounds of grid" do
      assert {:error, "12 exceeds the bounds of a 2x3 board"} = GridValidations.ind_within_bounds(12, 2, 3)
    end

    test "returns :ok if ind within bounds of grid" do
      assert :ok == GridValidations.ind_within_bounds(8, 3, 3)
    end
  end

  describe "sub_within_bounds/2" do
    setup do
      [
        grid: %Grid{rows: 3, cols: 3}
      ]
    end

    test "returns error tuple if sub exceeds bounds of grid", %{grid: grid} do
      assert {:error, "(3, 1) exceeds the bounds of a 3x3 board"} = GridValidations.sub_within_bounds({3, 1}, grid)
      assert {:error, "(1, 3) exceeds the bounds of a 3x3 board"} = GridValidations.sub_within_bounds({1, 3}, grid)
    end

    test "returns :ok if sub within bounds of grid", %{grid: grid} do
      assert :ok == GridValidations.sub_within_bounds({1, 1}, grid)
    end
  end

  describe "sub_within_bounds/3" do
    test "returns error tuple if sub exceeds bounds of grid" do
      assert {:error, "(3, 1) exceeds the bounds of a 3x3 board"} = GridValidations.sub_within_bounds({3, 1}, 3, 3)
      assert {:error, "(1, 3) exceeds the bounds of a 3x3 board"} = GridValidations.sub_within_bounds({1, 3}, 3, 3)
    end

    test "returns :ok if sub within bounds of grid" do
      assert :ok == GridValidations.sub_within_bounds({1, 1}, 2, 2)
    end
  end
end
