defmodule Hangman.MixProject do
  use Mix.Project

  def project do
    [
      app: :hangman,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: [
        flags: [
          # "-Wunmatched_returns",
          # :error_handling,
          # :underspecs,
          # :overspecs,
          # # :specdiffs, # This is giving me an error with the Game struct type
          # :overlapping_contract
        ]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: { Hangman.Runtime.Application, [] },
      extra_applications: [:logger],
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:dialyxir, "~> 1.4.3", only: [:dev, :test], runtime: false},
      {:dictionary, path: "../dictionary"}
    ]
  end
end
