defmodule GamesEngine.Physics.VelocityTest do
  use ExUnit.Case, async: true

  alias GamesEngine.Physics.Velocity

  describe "new/0" do
    test "returns new velocity struct with 0 speed" do
      assert %Velocity{x: 0, y: 0} = Velocity.new()
    end
  end
end
