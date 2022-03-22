defmodule Bench.MixProject do
  use Mix.Project

  def project do
    [
      app: :bench,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:benchee, "~> 1.0"},
      {:benchee_markdown, "~> 0.1"},
      {:floki, "~> 0.32.0", override: true},
      {:gluttony, path: "../", override: true},
      {:feedraptor, "~> 0.3.0"},
      {:elixir_feed_parser, "~> 0.0.1"},
      {:feeder_ex, "~> 1.1"}
    ]
  end
end
