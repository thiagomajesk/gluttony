defmodule Gluttony.MixProject do
  use Mix.Project

  def project do
    [
      app: :gluttony,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:saxy, "~> 1.4"},
      {:httpoison, "~> 1.8"},
      {:floki, "~> 0.32.0"},
      {:timex, "~> 3.0"},
      {:phoenix_html, "~> 3.2"}
    ]
  end
end
