defmodule Gluttony.Parser do
  @moduledoc """
  Deals with XML processing.
  """

  @behaviour Saxy.Handler

  import Gluttony.Helpers

  @itunes_namespace "http://www.itunes.com/dtds/podcast-1.0.dtd"
  @feedburner_namespace "http://rssnamespace.org/feedburner/ext/1.0"

  def parse_string(xml) do
    Saxy.parse_string(xml, __MODULE__, [])
  end

  @doc false
  def handle_event(:start_document, _prolog, _opts) do
    {:ok, %{feed: %{}, entries: [], handler: nil, stack: []}}
  end

  @doc false
  def handle_event(:end_document, _data, state) do
    {:ok, Map.take(state, [:feed, :entries])}
  end

  @doc false
  def handle_event(:start_element, {"rss", attributes}, state) do
    handler =
      case Map.new(attributes) do
        %{"version" => "2.0"} ->
          Gluttony.Handlers.RSS2Standard

        %{"version" => "2.0", "xmlns:itunes" => @itunes_namespace} ->
          Gluttony.Handlers.RSS2Itunes

        %{"version" => "2.0", "xmlns:feedburner" => @feedburner_namespace} ->
          Gluttony.Handlers.RSS2Feedburner

        _ ->
          {:halt, "No handler available to parse this feed #{inspect(attributes)}"}
      end

    {:ok, Map.put(state, :handler, handler)}
  end

  @doc false
  def handle_event(:start_element, {name, attributes}, %{handler: handler} = state) do
    # Push the current tag early to the stack so the calls
    # to :handle_element and :handle_content can consistently use
    # the stack to find the current scope we are processing.
    state = Map.update!(state, :stack, &push(name, &1))

    state =
      handler
      |> apply(:handle_element, [attributes, state.stack])
      |> handle_result(state)

    {:ok, state}
  end

  @doc false
  def handle_event(:end_element, _name, state) do
    {:ok, Map.update!(state, :stack, &pop(&1))}
  end

  @doc false
  def handle_event(:characters, chars, %{handler: handler} = state) do
    state =
      handler
      |> apply(:handle_content, [chars, state.stack])
      |> handle_result(state)

    {:ok, state}
  end

  defp handle_result(result_tuple, state) do
    case result_tuple do
      {:feed, keys, value} when is_list(keys) ->
        update_feed(state, keys, value)

      {:feed, key, value} ->
        update_feed(state, [key], value)

      {:entry, _chars_or_attrs} ->
        Map.update!(state, :entries, &[%{} | &1])

      {:entry, keys, value} when is_list(keys) ->
        update_entry(state, keys, value)

      {:entry, key, value} ->
        update_entry(state, [key], value)

      {:cont, _chars_or_attrs} ->
        state
    end
  end

  defp update_feed(state, keys, value) do
    feed = place_in(state.feed, keys, value)
    Map.replace!(state, :feed, feed)
  end

  defp update_entry(state, keys, value) do
    {entry, entries} = pop_current_entry(state.entries)
    entry = place_in(entry, keys, value)
    Map.replace!(state, :entries, [entry | entries])
  end

  # Get current entry (latest created) or create a new one.
  defp pop_current_entry([]), do: {nil, []}
  defp pop_current_entry([entry | entries]), do: {entry, entries}

  # Pushes a tag to the current stack.
  defp push(tag, []), do: [tag]
  defp push(tag, stack), do: [tag | stack]

  # Removes the last tag from the stack.
  defp pop([]), do: []
  defp pop(stack), do: tl(stack)
end
