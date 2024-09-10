defmodule GamesEngine.PhysicsTest do
  use ExUnit.Case, async: true

  alias GamesEngine.Grid.Coordinate
  alias GamesEngine.Physics
  alias GamesEngine.Physics.Velocity

  describe "translate/2" do
    setup do
      [
        coordinate: %Coordinate{row: 0, col: 0}
      ]
    end

    test "returns coordinate with updated position", %{coordinate: coordinate} do
      x_speed = 1
      y_speed = 5

      velocity = %Velocity{x: x_speed, y: y_speed}
      assert %Coordinate{col: ^x_speed, row: ^y_speed} = Physics.translate(coordinate, velocity)
    end

    test "coordinate's position is rounded if velocity components are floats", %{coordinate: coordinate} do
      x_speed = 1.1
      y_speed = 5.6

      velocity = %Velocity{x: x_speed, y: y_speed}
      assert %Coordinate{col: 1, row: 6} = Physics.translate(coordinate, velocity)
    end
  end

  describe "bounce/2" do
    setup do
      [
        velocity: %Velocity{x: -1.1, y: 2}
      ]
    end

    test ":horizontal bounce reflects the x component", %{velocity: velocity} do
      assert %Velocity{x: 1.1} = Physics.bounce(velocity, :horizontal)
    end

    test ":vertical bounce reflects the y component", %{velocity: velocity} do
      assert %Velocity{y: -2} = Physics.bounce(velocity, :vertical)
    end
  end
end
