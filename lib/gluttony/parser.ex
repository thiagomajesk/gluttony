defmodule Gluttony.Parser do
  @moduledoc """
  Deals with XML processing.

  # Remarks
  If CDATA is not getting pickedup, make sure the rss source
  was not processed or formatted in any form. Since we are not using a separate event
  to treat CDATA, we need to make sure there's no newlines between tag and content.
  More information about why this is necessary ca be found here: https://github.com/qcam/saxy/issues/98.
  """

  @behaviour Saxy.Handler

  @itunes_namespace "http://www.itunes.com/dtds/podcast-1.0.dtd"
  @feedburner_namespace "http://rssnamespace.org/feedburner/ext/1.0"
  @atom_namespace "http://www.w3.org/2005/Atom"

  @doc false
  def handle_event(:start_document, _prolog, opts) do
    {:ok, %{feed: %{}, entries: [], handler: nil, stack: [], raw: opts[:raw] || true, cache: %{}}}
  end

  @doc false
  def handle_event(:end_document, _data, %{raw: true} = state) do
    {:ok, Map.take(state, [:feed, :entries])}
  end

  @doc false
  def handle_event(:end_document, _data, %{handler: handler, raw: false} = state) do
    {:ok, Gluttony.Handler.to_feed(handler, Map.take(state, [:feed, :entries]))}
  end

  @doc false
  def handle_event(:start_element, {name, attributes}, %{handler: nil} = state) do
    case {name, Map.new(attributes)} do
      {"rss", %{"version" => "2.0"}} ->
        {:ok, %{state | handler: Gluttony.Handlers.RSS2Standard}}

      {"rss", %{"version" => "2.0", "xmlns:itunes" => @itunes_namespace}} ->
        {:ok, %{state | handler: Gluttony.Handlers.RSS2Itunes}}

      {"rss", %{"version" => "2.0", "xmlns:feedburner" => @feedburner_namespace}} ->
        {:ok, %{state | handler: Gluttony.Handlers.RSS2Feedburner}}

      {"feed", %{"xmlns" => @atom_namespace}} ->
        {:ok, %{state | handler: Gluttony.Handlers.Atom1Standard}}

      _ ->
        {:halt, "No handler available to parse this feed #{inspect(attributes)}"}
    end
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
  def handle_event(:end_element, name, %{handler: handler, stack: stack, cache: cache} = state) do
    {cached, cache} = Map.pop(cache, to_string(name))
    state = Gluttony.Handler.handle_cached(handler, cached, state)
    {:ok, %{state | stack: pop(stack), cache: cache}}
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
