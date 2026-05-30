# Gluttony

Compliant elixir RSS 2.0 and Atom 1.0 parser.
Ingests and parses RSS feeds and returns raw data that can be enriched by unfurling URLs.

## Installation

Add `gluttony` to the list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:gluttony, "~> 0.2.0"}
  ]
end
```
## Documentation

Documentation can be found at <https://hexdocs.pm/gluttony>.

## Benchmarks

Thanks to [`Saxy`](https://github.com/qcam/saxy), Gluttony is probably one of the fastest RSS libraries in the ecosystem (not counting low level NIF wrappers). You can run the benchmark locally by yourself with `elixir bench/bench.exs`. Also check the existing results in [`/bench/output/result.md`](/bench/output/result.md).

> ⚠️ Notice that I'm currently using WSL2 to run the benchmarks, so the results may actually be more optimistic without the virtualization layer. I'm also currently only yielding half of the available resources from my machine to the VM.

The data I'm using to run the benchmarks is similar to what [`fast_rss`](https://github.com/avencera/fast_rss) (another RSS feed library that uses Rust for speed) is also using, so take a look on their benchmarks for some interesting comparisons.

### Metrics

In the worst cases, Gluttony was more memory efficient than the current slowest alternative by using `0.0246 GB` compared to [`feedraptor's`](https://github.com/merongivian/feedraptor) surprising `8.22 GB`. Not only this, but in some cases finishing parsing the whole RSS feed `424.26x` faster than the current worst alternative.

## TODOs

- Better document the available options
- Add typespecs to the common result interface (`Feed` / `Entry`)
