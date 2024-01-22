defmodule GamesEngine.Grid.Tile do
  @moduledoc """
  Tile Component
  Representation of a Game Tile on a Grid
  """

  alias GamesEngine.Grid.Coordinate

  @type t :: %__MODULE__{}

  defstruct coordinate: nil, attributes: nil

  @doc """
  Creates a new `%Tile{}` struct
  row/col validation is relegated to the `%Coordinate{}` module
  """
  @spec new({non_neg_integer(), non_neg_integer()}) :: t() | {:error, String.t()}
  def new({row, col}) do
    with %Coordinate{} = coordinate <- Coordinate.new({row, col}) do
      %__MODULE__{coordinate: coordinate}
    end
  end

  @spec new({non_neg_integer(), non_neg_integer()}, map()) :: t() | {:error, String.t()}
  def new({row, col}, attributes) do
    with tile <- new({row, col}) do
      %{tile | attributes: attributes}
    end
  end

  @doc """
  Replaces the entire attributes map of a `%Tile{}` with a new map
  """
  @spec replace_attributes(t(), map()) :: t()
  def replace_attributes(%__MODULE__{} = tile, attributes) when is_map(attributes) do
    %{tile | attributes: attributes}
  end

  def replace_attributes(_tile, _attributes), do: {:error, "expected map for :attributes"}

  @doc """
  Updates an existing attribute of a `%Tile{}`
  """
  @spec update_attribute(t(), atom(), term()) :: t()
  def update_attribute(%__MODULE__{} = tile, key, value) do
    updated_attributes =
      tile
      |> Map.get(:attributes)
      |> Map.replace(key, value)

    %{tile | attributes: updated_attributes}
  end

  @doc """
  Adds a new attributes to a `%Tile{}`
  Will not overwrite the attribute if it already exists
  """
  @spec put_new_attribute(t(), atom(), term()) :: t()
  def put_new_attribute(%__MODULE__{} = tile, key, value) do
    updated_attributes =
      tile
      |> Map.get(:attributes)
      |> Map.put_new(key, value)

    %{tile | attributes: updated_attributes}
  end
end
