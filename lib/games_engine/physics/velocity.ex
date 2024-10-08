defmodule GamesEngine.Physics.Velocity do
  @moduledoc """
  Velocity module
  """
  alias GamesEngine.Validations.NumericValidations

  @type t :: %__MODULE__{}

  @enforce_keys [:x, :y]
  defstruct x: 0, y: 0

  @doc """
  Creates a new `%Velocity{}` struct with 0 speed in the x and y directions
  """
  @spec new() :: t()
  def new, do: %__MODULE__{x: 0, y: 0}

  @doc """
  Creates a new `%Velocity{}` struct based on a direction vector
  """
  @spec new({number(), number()}) :: t() | {:error, String.t()}
  def new({x_speed, y_speed}) do
    with(
      :ok <- NumericValidations.numeric(x_speed),
      :ok <- NumericValidations.numeric(y_speed)
    ) do
      %__MODULE__{x: x_speed, y: y_speed}
    end
  end

  @doc """
  Creates a new `%Velocity{}` struct based on a speed and heading
  Heading is expected in degrees
  """
  @spec new(number(), number()) :: t() | {:error, String.t()}
  def new(speed, heading) do
    with(
      :ok <- NumericValidations.numeric(speed),
      :ok <- NumericValidations.numeric(heading),
      :ok <- NumericValidations.within_range(heading, 0, 360)
    ) do
      heading_rad = heading * :math.pi() / 180
      x_speed = speed * :math.cos(heading_rad)
      y_speed = speed * :math.sin(heading_rad)

      new({x_speed, y_speed})
    end
  end
end
