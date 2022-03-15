defmodule Gluttony.Parser do
  @moduledoc """
  Deals with XML processing.
  """

  @behaviour Saxy.Handler

  @itunes_namespace "http://www.itunes.com/dtds/podcast-1.0.dtd"
  @feedburner_namespace "http://rssnamespace.org/feedburner/ext/1.0"

  def parse_string(xml) do
    Saxy.parse_string(xml, __MODULE__, [])
  end

  @doc false
  def handle_event(:start_document, _prolog, _opts) do
    {:ok, %{channel: nil, items: [], handler: nil, stack: []}}
  end

  @doc false
  def handle_event(:end_document, _data, state) do
    {:ok, Map.take(state, [:channel, :items])}
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
  def handle_event(:start_element, {name, attributes}, state) do
    # Push the current tag early to the stack so the calls
    # to :handle_element and :handle_content can consistently use
    # the stack to find the current scope we are processing.
    state = Map.update!(state, :stack, &push(name, &1))

    %{channel: channel, items: items, handler: handler, stack: stack} = state

    # TODO: Allow handlers to return a key/value pair so we have more flexibility to modify the current state.
    # For instance: {:channel, modified_channel} or {:items, modified_items}.
    args = [{channel, items}, attributes, stack]
    {channel, items} = apply(handler, :handle_element, args)

    state =
      state
      |> Map.put(:channel, channel)
      |> Map.put(:items, items)

    {:ok, state}
  end

  @doc false
  def handle_event(:end_element, _name, state) do
    {:ok, Map.update!(state, :stack, &pop(&1))}
  end

  @doc false
  def handle_event(:characters, chars, state) do
    %{channel: channel, items: items, handler: handler, stack: stack} = state

    args = [{channel, items}, chars, stack]
    {channel, items} = apply(handler, :handle_content, args)

    state =
      state
      |> Map.put(:channel, channel)
      |> Map.put(:items, items)

    {:ok, state}
  end

  # Pushes a tag to the current stack.
  defp push(tag, []), do: [tag]
  defp push(tag, stack), do: [tag | stack]

  # Removes the last tag from the stack.
  defp pop([]), do: []
  defp pop(stack), do: tl(stack)
end
