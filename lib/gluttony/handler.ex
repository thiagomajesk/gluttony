defmodule Gluttony.Handler do
  @moduledoc """
  This module defines the behaviour for handlers.

  Both `handle_element/2`, `handle_content/2` and `handle_cached/2` should return on of the following result tuples:

  - `{:entry, chars_or_attrs}` - To indicate that a new entry should be created.
  - `{:entry, :key, value}` - To indicate that a entry should be updated with the given key and value.
  - `{:feed, :key, value}` - To indicate that the feed should be updated with the given key and value.
  - `{:cache, :key}` - To indicate that the given key should be cached.
    Because successive calls with the same key will clean the previous value, this should only be called on `handle_element`.
    This will guarantee that the cache will live through the tag lifecycle, instead of being cleaned on whenever new content is found.
  - `{:cache, :key, value}` - To indicate that the given key should be cached with the given value.
  - `{:cont, chars_or_attrs}` - To indicate that the current element should be ignored.

  If the value is a list, it will be appended to the existing value. Otherwise, it will replace the current value.
  Its also possible to pass a list as the path to create a nested structure (all intermidiate values will be created).
  """

  alias Gluttony.State

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
  def handle_element(impl, attrs, %State{stack: stack} = state) do
    attrs
    |> impl.handle_element(stack)
    |> handle_result(state)
  end

  @doc false
  def handle_content(impl, chars, %State{stack: stack} = state) do
    chars
    |> impl.handle_content(stack)
    |> handle_result(state)
  end

  @doc false
  def handle_cached(_impl, nil, state), do: state

  def handle_cached(impl, cached, %State{stack: stack} = state) do
    cached
    |> impl.handle_cached(stack)
    |> handle_result(state)
  end

  defp handle_result(result, %State{entries: entries} = state) do
    case result do
      {:feed, keys, value} when is_list(keys) ->
        State.update_feed(state, keys, value)

      {:feed, key, value} ->
        State.update_feed(state, [key], value)

      {:entry, _chars_or_attrs} ->
        %{state | entries: [%{} | entries]}

      {:entry, keys, value} when is_list(keys) ->
        State.update_entry(state, keys, value)

      {:entry, key, value} ->
        State.update_entry(state, [key], value)

      {:cache, key} ->
        State.update_cache(state, [key])

      {:cache, keys, value} when is_list(keys) ->
        State.update_cache(state, keys, value)

      {:cache, key, value} ->
        State.update_cache(state, [key], value)

      {:cont, _chars_or_attrs} ->
        state
    end
  end
end
