defmodule GamesEngine.Validations.GridValidationsTest do
  use ExUnit.Case, async: true

  alias GamesEngine.Validations.GridValidations

  describe "ind_within_bounds/2" do
    test "returns error tuple if ind exceeds bounds of grid" do
      assert {:error, "12 exceeds the bounds of a 2x3 board"} =
               GridValidations.ind_within_bounds(12, {2, 3})
    end

    test "returns :ok if ind within bounds of grid" do
      assert :ok == GridValidations.ind_within_bounds(8, {3, 3})
    end
  end
end
