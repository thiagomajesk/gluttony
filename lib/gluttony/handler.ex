defmodule Gluttony.Handler do
  @moduledoc """
  This module defines the behaviour for handlers.

  Both `handle_element/2` and `handle_content/2` should return on of the following result tuples:

  - `{:entry, chars_or_attrs}` - To indicate that a new entry should be created.
  - `{:entry, :key, value} - To indicate that a entry should be updated with the given key and value.
  - `{:feed, :key, value} - To indicate that the feed should be updated with the given key and value.
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
  Transforms the processed parsed data into a `Gluttony.Feed` struct.
  """
  @callback to_feed(feed :: map(), entries :: list(map())) :: Gluttony.Feed.t()

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
  def to_feed(impl, %{feed: feed, entries: entries}) do
    impl.to_feed(feed, entries)
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

  # Get current entry (latest created) or create a new one.
  defp pop_current_entry([]), do: {nil, []}
  defp pop_current_entry([entry | entries]), do: {entry, entries}
end
