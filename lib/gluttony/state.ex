defmodule Gluttony.State do
  @moduledoc false

  alias __MODULE__
  import Gluttony.Helpers

  defstruct [:raw, :handlers, stack: [], cache: %{}, feed: %{}, entries: []]

  def update_feed(%State{feed: feed} = state, keys, value) do
    feed = place_in(feed, keys, value)
    %{state | feed: feed}
  end

  def update_entry(%State{entries: entries} = state, keys, value) do
    {entry, entries} = pop_current_entry(entries)
    entry = place_in(entry, keys, value)
    %{state | entries: [entry | entries]}
  end

  def update_cache(%State{cache: cache} = state, [key | keys], value \\ %{}) do
    # Converts the first key (actual cache key) to a string.
    # This allows us to use the cache key as a string to match the Saxy event.
    # Because of this, we don't have to convert the tag name to atom to compare.
    keys = [to_string(key) | keys]
    cache = place_in(cache, keys, value)
    %{state | cache: cache}
  end

  # Pushes a tag to the current stack.
  def push(%State{stack: []} = state, tag), do: %State{state | stack: [tag]}
  def push(%State{stack: stack} = state, tag), do: %State{state | stack: [tag | stack]}

  # Removes the last tag from the stack.
  def pop(%State{stack: []} = state), do: %State{state | stack: []}
  def pop(%State{stack: [_head | tail]} = state), do: %State{state | stack: tail}

  def result(%State{raw: true} = state) do
    Map.take(state, [:entries, :feed])
  end

  def result(%State{raw: false, feed: feed, entries: entries}) do
    Gluttony.Mapper.map(feed, entries)
  end

  # Get current entry (latest created) or create a new one.
  defp pop_current_entry([]), do: {nil, []}
  defp pop_current_entry([entry | entries]), do: {entry, entries}
end
