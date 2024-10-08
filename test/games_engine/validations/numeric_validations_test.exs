defmodule GamesEngine.Validations.NumericValidationsTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias GamesEngine.Validations.NumericValidations

  describe "non_neg_integer/1" do
    property "returns error tuple if given negative integer" do
      check all input <- negative_integer() do
        {:error, msg} = NumericValidations.non_neg_integer(input)
        assert msg == "Expected non-negative integer, received #{input}"
      end
    end

    property "returns error tuple if input is not an integer" do
      check all input <- non_integer() do
        {:error, msg} = NumericValidations.non_neg_integer(input)
        assert msg == "Expected non-negative integer, received #{inspect input}"
      end
    end

    property "returns :ok if input is a non negative integer" do
      check all input <- non_negative_integer() do
        assert :ok == NumericValidations.non_neg_integer(input)
      end
    end
  end

  describe "numeric/1" do
    property "returns error tuple if given non numeric input" do
      check all input <- non_numeric() do
        {:error, msg} = NumericValidations.numeric(input)
        assert msg == "Expected numeric value, received #{inspect input}"
      end
    end

    property "returns ok if input is numeric" do
      check all input <- numeric() do
        assert :ok == NumericValidations.numeric(input)
      end
    end
  end

  describe "within_range/3" do
    test "returns error tuple if number below range" do
      input = 1
      min = 2
      max = 3

      assert {:error, message} = NumericValidations.within_range(input, min, max)
      assert message == "1 is not within the range of [2, 3]"
    end

    test "returns error tuple if number exceeds range" do
      input = 3.3
      min = 1
      max = 2.2

      assert {:error, message} = NumericValidations.within_range(input, min, max)
      assert message == "3.3 is not within the range of [1, 2.2]"
    end

    test "returns :ok if number within range" do
      input = -1
      min = -3
      max = 5.5

      assert :ok == NumericValidations.within_range(input, min, max)
    end

    test "returns :ok if number equals lower bound" do
      input = 1
      min = 1
      max = 3

      assert :ok == NumericValidations.within_range(input, min, max)
    end

    test "returns :ok if number equals upper bound" do
      input = 3
      min = 1
      max = 3

      assert :ok == NumericValidations.within_range(input, min, max)
    end
  end

  defp negative_integer(min_bound \\ -100) do
    gen all(neg_integer <- member_of(min_bound..-1)) do
      neg_integer
    end
  end

  defp numeric do
    gen all(
          integer <- integer(),
          float <- float()
        ) do
      Enum.random([integer, float])
    end
  end

  defp non_integer do
    gen all(
          atom <- atom(:alphanumeric),
          string <- string(:ascii),
          boolean <- boolean(),
          float <- float()
        ) do
      Enum.random([atom, string, boolean, float])
    end
  end

  defp non_numeric do
    gen all(
          atom <- atom(:alphanumeric),
          string <- string(:ascii),
          boolean <- boolean()
        ) do
      Enum.random([atom, string, boolean])
    end
  end
end
