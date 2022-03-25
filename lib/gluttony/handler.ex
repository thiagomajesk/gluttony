defmodule Gluttony.Handler do
  @moduledoc """
  This module defines the behaviour for handlers.

  Both `handle_element/2` and `handle_content/2` should return on of the following result tuples:

  - `{:entry, chars_or_attrs}` - To indicate that a new entry should be created.
  - `{:entry, :key, value} - To indicate that a entry should be updated with the given key and value.
  - `{:feed, :key, value} - To indicate that the feed should be updated with the given key and value.
  - `{:cache, :key}` - To indicate that the given key should be cached.
    Because successive calls with the same key will clean the previous value, this should only be called on `handle_element`.
    This will guarantee that the cache will live through the tag lifecycle, instead of being cleaned on whenever new content is found.
  - `{:cache, :key, value}` - To indicate that the given key should be cached with the given value.
  - `{:cont, chars_or_attrs}` - To indicate that the current element should be ignored.

  If the value is a list, it will be appended to the existing value. Otherwise, it will replace the current value.
  Its also possible to pass a list as the path to create a nested structure (all intermidiate values will be created).
  """

  import Gluttony.Helpers

  @type attrs :: list({binary(), term()})
  @type stack :: list(binary())
  @type chars :: binary() | list(binary())

  @type path :: atom() | list(atom())

  @type result ::
          {:entry, term()}
          | {:entry, path(), term()}
          | {:feed, path(), term()}
          | {:cache, atom()}
          | {:cache, path(), term()}
          | {:cont, term()}

  @doc """
  This callback is called when a start element is encountered.
  """
  @callback handle_element(attrs :: attrs(), stack :: stack()) :: result()

  @doc """
  This callback is called when a content of a element is encountered.
  """
  @callback handle_content(chars :: chars(), stack :: stack()) :: result()

  @doc """
  This callback is called when and element is about to finish.
  """
  @callback handle_cached(cached :: term, stack :: stack()) :: result()

  @doc false
  def handle_element(impl, attrs, %{stack: stack} = state) do
    attrs
    |> impl.handle_element(stack)
    |> handle_result(state)
  end

  @doc false
  def handle_content(impl, chars, %{stack: stack} = state) do
    chars
    |> impl.handle_content(stack)
    |> handle_result(state)
  end

  @doc false
  def handle_cached(_impl, nil, state), do: state

  def handle_cached(impl, cached, %{stack: stack} = state) do
    cached
    |> impl.handle_cached(stack)
    |> handle_result(state)
  end

  defp handle_result(result, %{entries: entries} = state) do
    case result do
      {:feed, keys, value} when is_list(keys) ->
        update_feed(state, keys, value)

      {:feed, key, value} ->
        update_feed(state, [key], value)

      {:entry, _chars_or_attrs} ->
        %{state | entries: [%{} | entries]}

      {:entry, keys, value} when is_list(keys) ->
        update_entry(state, keys, value)

      {:entry, key, value} ->
        update_entry(state, [key], value)

      {:cache, key} ->
        update_cache(state, [key])

      {:cache, keys, value} when is_list(keys) ->
        update_cache(state, keys, value)

      {:cache, key, value} ->
        update_cache(state, [key], value)

      {:cont, _chars_or_attrs} ->
        state
    end
  end

  defp update_feed(%{feed: feed} = state, keys, value) do
    feed = place_in(feed, keys, value)
    %{state | feed: feed}
  end

  defp update_entry(%{entries: entries} = state, keys, value) do
    {entry, entries} = pop_current_entry(entries)
    entry = place_in(entry, keys, value)
    %{state | entries: [entry | entries]}
  end

  defp update_cache(%{cache: cache} = state, [key | keys], value \\ %{}) do
    # Converts the first key (actual cache key) to a string.
    # This allows us to use the cache key as a string to match the Saxy event.
    # Because of this, we don't have to convert the tag name to atom to compare.
    keys = [to_string(key) | keys]
    cache = place_in(cache, keys, value)
    %{state | cache: cache}
  end

  # Get current entry (latest created) or create a new one.
  defp pop_current_entry([]), do: {nil, []}
  defp pop_current_entry([entry | entries]), do: {entry, entries}
end
