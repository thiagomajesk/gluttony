defmodule Gluttony.MixProject do
  use Mix.Project

  @version "0.3.0"
  @url "https://github.com/thiagomajesk/gluttony"

  def project do
    [
      app: :gluttony,
      version: @version,
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      docs: docs(),
      aliases: aliases(),
      deps: deps()
    ]
  end

  def cli do
    [
      preferred_envs: [
        vcr: :test,
        "vcr.delete": :test,
        "vcr.check": :test,
        "vcr.show": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description() do
    "Compliant RSS 2.0 and Atom 1.0 parser"
  end

  defp package do
    [
      maintainers: ["Thiago Majesk Goulart"],
      licenses: ["AGPL-3.0-only"],
      links: %{"GitHub" => @url},
      files: ~w(lib mix.exs README.md LICENSE)
    ]
  end

  defp docs() do
    [
      source_ref: "v#{@version}",
      main: "README",
      canonical: "http://hexdocs.pm/gluttony",
      source_url: @url,
      extras: [
        "README.md": [filename: "README"]
      ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:saxy, "~> 1.6"},
      {:httpoison, "~> 1.8 or ~> 2.0"},
      {:floki, "~> 0.34"},
      {:timex, "~> 3.0"},
      {:phoenix_html, "~> 3.2 or ~> 4.0"},
      {:exvcr, "~> 0.13", only: :test},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.29", only: :dev, runtime: false}
    ]
  end

  defp aliases do
    [
      quality: [
        "format --check-formatted",
        "compile --warnings-as-errors",
        "credo --strict",
        "cmd env MIX_ENV=test mix test"
      ]
    ]
  end
end
