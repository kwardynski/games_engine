defmodule GamesEngine.MixProject do
  use Mix.Project

  def project do
    [
      app: :games_engine,
      version: "0.2.2",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      description: description(),
      package: package(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        "ci.test": :test,
        coveralls: :test,
        "coveralls.html": :test
      ]
    ]
  end

  defp description do
    """
    Elixir library with utilities for games, such as helpful coordinate conversions.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Kacper Wardynski"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/kwardynski/games_engine"}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.31", only: :dev, runtime: false},

      # SCA
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:sobelow, "~> 0.13", only: [:dev, :test], runtime: false},

      # Testing
      {:excoveralls, "~> 0.18", only: :test},
      {:stream_data, "~> 1.0.0", only: [:dev, :test]}
    ]
  end

  defp aliases do
    [
      "ci.test": ["coveralls.html"]
    ]
  end
end
