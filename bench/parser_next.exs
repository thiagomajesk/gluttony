feeds = ~w(anxiety ben dave sleepy)
iterations = 100

Logger.configure(level: :warning)

files =
  Map.new(feeds, fn name ->
    path = Path.expand("data/#{name}.rss", __DIR__)
    {name, File.read!(path)}
  end)

parsers = [
  {"parser_next", &Gluttony.ParserNext.parse/1},
  {"v1", &Gluttony.parse_string/1}
]

for {feed, xml} <- files do
  IO.puts(feed)

  for {name, parser} <- parsers do
    {us, _result} = :timer.tc(fn -> for _ <- 1..iterations, do: parser.(xml) end)

    ms =
      us
      |> Kernel./(iterations)
      |> Kernel./(1000)
      |> Float.round(2)

    IO.puts("  #{name}: #{ms} ms")
  end
end
