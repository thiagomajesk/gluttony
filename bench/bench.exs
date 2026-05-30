Mix.install(
  [
    {:benchee, "== 1.1.0"},
    {:benchee_markdown, "== 0.2.7"},
    {:floki, "== 0.32.0", override: true},
    {:gluttony, path: Path.expand("..", __DIR__), override: true},
    {:feedraptor, "== 0.3.0"},
    {:elixir_feed_parser, "== 0.0.1"},
    {:feeder_ex, "== 1.1.0"}
  ]
)

data = [
  "anxiety",
  "ben",
  "daily",
  "dave",
  "stuff",
  "sleepy"
]

files = Map.new(data, fn name ->
  content =
    "data/#{name}.rss"
    |> Path.expand(__DIR__)
    |> File.read!()

  {name, content}
end)

benchmark = %{
  "gluttony" => &Gluttony.parse_string/1,
  "elixir_feed_parser" => &ElixirFeedParser.parse/1,
  "feed_raptor" => &Feedraptor.parse/1,
  "feeder_ex" => &FeederEx.parse/1
}

Benchee.run(benchmark,
  warmup: 5,
  time: 30,
  memory_time: 1,
  inputs: files,
  formatters: [
    {Benchee.Formatters.Markdown, file: Path.expand("output/result.md", __DIR__)},
    Benchee.Formatters.Console
  ]
)
