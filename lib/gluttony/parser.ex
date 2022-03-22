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

    {:ok, %{state | handler: handler}}
  end

  @doc false
  def handle_event(:start_element, {name, attributes}, %{handler: handler, stack: stack} = state) do
    # Push the current tag early to the stack so the calls
    # to :handle_element and :handle_content can consistently use
    # the stack to find the current scope we are processing.
    state = %{state | stack: push(name, stack)}

    {:ok, Gluttony.Handler.handle_element(handler, attributes, state)}
  end

  @doc false
  def handle_event(:end_element, _name, %{stack: stack} = state) do
    {:ok, %{state | stack: pop(stack)}}
  end

  @doc false
  def handle_event(:characters, chars, %{handler: handler} = state) do
    {:ok, Gluttony.Handler.handle_content(handler, chars, state)}
  end

  # Pushes a tag to the current stack.
  defp push(tag, []), do: [tag]
  defp push(tag, stack), do: [tag | stack]

  # Removes the last tag from the stack.
  defp pop([]), do: []
  defp pop([_head | tail]), do: tail
end
