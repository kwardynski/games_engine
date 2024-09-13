defmodule GamesEngine.Physics.VelocityTest do
  use ExUnit.Case, async: true

  alias GamesEngine.Physics.Velocity

  describe "new/0" do
    test "returns new velocity struct with 0 speed" do
      assert %Velocity{x: 0, y: 0} = Velocity.new()
    end
  end

  describe "new/1" do
    test "returns error tuple if x_speed is non numeric" do
      assert {:error, _msg} = Velocity.new({:non_numeric, 0})
    end

    test "returns error tuple if y_speed is non numeric" do
      assert {:error, _msg} = Velocity.new({0, :non_numeric})
    end

    test "returns %Velocity{} struct if input is valid" do
      x_speed = 1
      y_speed = 420.69

      assert %Velocity{x: ^x_speed, y: ^y_speed} = Velocity.new({x_speed, y_speed})
    end
  end

  describe "new/2" do
    test "returns error tuple if speed is non numeric" do
      assert {:error, _msg} = Velocity.new(:non_numeric, 180)
    end

    test "returns error tuple if heading is non numeric" do
      assert {:error, _msg} = Velocity.new(20, :non_numeric)
    end

    test "returns error tuple if heading is < 0" do
      assert {:error, _msg} = Velocity.new(20, -1)
    end

    test "returns error tuple if heading > 360" do
      assert {:error, _msg} = Velocity.new(20, 361)
    end

    test "correctly calculates velocity based on speed and heading" do
      unit_circle_components = [
        {0, 1, 0},
        {45, :math.sqrt(2) / 2, :math.sqrt(2) / 2},
        {60, 0.5, :math.sqrt(3) / 2},
        {90, 0, 1},
        {135, -:math.sqrt(2) / 2, :math.sqrt(2) / 2},
        {180, -1, 0},
        {225, -:math.sqrt(2) / 2, -:math.sqrt(2) / 2},
        {270, 0, -1},
        {315, :math.sqrt(2) / 2, -:math.sqrt(2) / 2},
        {360, 1, 0}
      ]

      Enum.each(unit_circle_components, fn {angle, expected_x, expected_y} ->
        %Velocity{x: returned_x, y: returned_y} = Velocity.new(1, angle)
        assert_close_enough(returned_x, expected_x)
        assert_close_enough(returned_y, expected_y)
      end)
    end
  end

  defp assert_close_enough(float_1, float_2) do
    assert Float.round(float_1 / 1, 3) == Float.round(float_2 / 1, 3)
  end
end
