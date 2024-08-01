data = [
  "anxiety",
  "ben",
  "daily",
  "dave",
  "stuff",
  "sleepy"
]

files = Map.new(data, fn name ->
  content = "data/#{name}.rss"
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
    {Benchee.Formatters.Markdown, file: Path.expand("output/parse.md", __DIR__)},
    Benchee.Formatters.Console
  ]
)
