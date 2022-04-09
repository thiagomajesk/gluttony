# Gluttony

Compliant elixir RSS 2.0 and Atom 1.0 parser.  
Ingests and parses RSS feeds and returns raw data that can be enriched by unfurling URLs.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `gluttony` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:gluttony, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/gluttony>.

## Benchmarks

Thanks to [`Saxy`](https://github.com/qcam/saxy), Gluttony is probably one of the fastest libraries to parse RSS feeds out there. That is, libraries that use pure Elixir of course (without low level NIFs). You can run the benchmark project or see previous results in the `/bench` folder.

> ⚠️ Notice that I'm currently using WSL2 to run the benchmarks, so the results may actually be more optimistic without the virtualization layer. I'm also currently only yielding half of the available resources from my machine to the VM.

The data I'm using to run the benchmarks is similar to what [`fast_rss`](https://github.com/avencera/fast_rss) (another RSS feed library that uses Rust for speed) is also using, so take a look on their benchmarks for some intersting comparissons.

### Metrics

In the worst cases, Gluttony was more memory efficient than the current slowest alternative by using `0.0246 GB` compared to [`feedraptor's`](https://github.com/merongivian/feedraptor) surprising `8.22 GB`. Not only this, but in some cases finishing parsing the whole RSS feed `424.26x` faster than the current worst alternative.

## TODOs

- Better document available options
- Add typespecs to the common result interface (`Feed` / `Entry`)
