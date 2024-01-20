defmodule GamesEngine.Repo do
  use Ecto.Repo,
    otp_app: :games_engine,
    adapter: Ecto.Adapters.Postgres
end
