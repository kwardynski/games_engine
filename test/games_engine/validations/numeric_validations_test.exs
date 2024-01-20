defmodule GamesEngine.Validations.NumericValidationsTest do
  use ExUnit.Case, async: true

  alias GamesEngine.Validations.NumericValidations

  describe "non_neg_integer/1" do
    test "returns error tuple if given negative integer" do
      assert {:error, "Expected non-negative integer, received -12"} =
               NumericValidations.non_neg_integer(-12)
    end

    test "returns error tuple if input is not an integer" do
      invalid_inputs = [:atom, 12.12, "string"]

      Enum.each(invalid_inputs, fn invalid_input ->
        assert {:error, _} = NumericValidations.non_neg_integer(invalid_input)
      end)
    end

    test "returns :ok if input is a non negative integer" do
      assert :ok = NumericValidations.non_neg_integer(0)
      assert :ok = NumericValidations.non_neg_integer(12)
    end
  end
end
