defmodule GamesEngine.Validations.GridValidationsTest do
  use ExUnit.Case, async: true

  doctest GamesEngine.Validations.GridValidations

  alias GamesEngine.Grid
  alias GamesEngine.Grid.Point
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

  describe "point_within_bounds/2" do
    setup do
      [
        grid: %Grid{rows: 10, cols: 10}
      ]
    end

    test "returns :ok if point within bounds of grid", %{grid: grid} do
      point = %Point{x: 1, y: 3.5}
      assert :ok == GridValidations.point_within_bounds(point, grid)
    end

    test "returns error tuple if point exceeds top bound of grid", %{grid: grid} do
      point = %Point{x: 7, y: -1.1}
      {:error, errors} = GridValidations.point_within_bounds(point, grid)

      assert %{
               top: true,
               bottom: false,
               left: false,
               right: false
             } = errors
    end

    test "returns error tuple if point exceeds bottom bound of grid", %{grid: grid} do
      point = %Point{x: 7, y: 10.1}
      {:error, errors} = GridValidations.point_within_bounds(point, grid)

      assert %{
               top: false,
               bottom: true,
               left: false,
               right: false
             } = errors
    end

    test "returns error tuple if point exceeds left bound of grid", %{grid: grid} do
      point = %Point{x: -12, y: 7}
      {:error, errors} = GridValidations.point_within_bounds(point, grid)

      assert %{
               top: false,
               bottom: false,
               left: true,
               right: false
             } = errors
    end

    test "returns error tuple if point exceeds right bound of grid", %{grid: grid} do
      point = %Point{x: 12.1, y: 7.3}
      {:error, errors} = GridValidations.point_within_bounds(point, grid)

      assert %{
               top: false,
               bottom: false,
               left: false,
               right: true
             } = errors
    end

    test "returns error tuple if point exceeds bounds of grid in multiple directions", %{grid: grid} do
      point = %Point{x: -0.1, y: 11}
      {:error, errors} = GridValidations.point_within_bounds(point, grid)

      assert %{
               top: false,
               bottom: true,
               left: true,
               right: false
             } = errors
    end
  end
end
