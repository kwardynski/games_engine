defmodule GamesEngine.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      GamesEngineWeb.Telemetry,
      # Start the Ecto repository
      GamesEngine.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: GamesEngine.PubSub},
      # Start Finch
      {Finch, name: GamesEngine.Finch},
      # Start the Endpoint (http/https)
      GamesEngineWeb.Endpoint
      # Start a worker by calling: GamesEngine.Worker.start_link(arg)
      # {GamesEngine.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GamesEngine.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GamesEngineWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
