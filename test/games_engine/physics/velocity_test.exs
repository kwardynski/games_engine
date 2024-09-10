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
end
