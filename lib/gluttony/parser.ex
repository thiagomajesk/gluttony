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
    {:ok, %{feed: %{}, entries: [], handlers: nil, stack: [], raw: opts[:raw] || true, cache: %{}}}
  end

  @doc false
  def handle_event(:end_document, _data, state) do
    {:ok, Map.take(state, [:feed, :entries])}
  end

  @doc false
  def handle_event(:start_element, {name, attributes}, %{handlers: nil} = state) do
    case {name, Map.new(attributes)} do
      {"rss", %{"version" => "2.0"} = attrs} ->
        handlers = discover_handlers(attrs, Gluttony.Handlers.RSS2Standard)
        {:ok, %{state | handlers: handlers}}

      {"feed", %{"xmlns" => @atom_namespace}} ->
        {:ok, %{state | handlers: [Gluttony.Handlers.Atom1Standard]}}

      _ ->
        {:halt, "No handler available to parse this feed #{inspect(attributes)}"}
    end
  end

  @doc false
  def handle_event(:start_element, {name, attributes}, %{handlers: handlers, stack: stack} = state) do
    # Push the current tag early to the stack so the calls
    # to :handle_element and :handle_content can consistently use
    # the stack to find the current scope we are processing.
    state = %{state | stack: push(name, stack)}

    {:ok, dispatch_events(handlers, :handle_element, attributes, state)}
  end

  @doc false
  def handle_event(:end_element, name, %{handlers: handlers, stack: stack, cache: cache} = state) do
    {cached, cache} = Map.pop(cache, to_string(name))

    state = dispatch_events(handlers, :handle_cached, cached, state)

    {:ok, %{state | stack: pop(stack), cache: cache}}
  end

  @doc false
  def handle_event(:characters, "\n" <> _, state) do
    {:ok, state}
  end

  @doc false
  def handle_event(:characters, chars, %{handlers: handlers} = state) do
    chars = String.trim(chars)

    {:ok, dispatch_events(handlers, :handle_content, chars, state)}
  end

  # Iterate over all the handlers calling the respective
  # processing function and returns the resulting state.
  defp dispatch_events(handlers, fun, content, state) do
    Enum.reduce(handlers, state, fn handler, state ->
      apply(Gluttony.Handler, fun, [handler, content, state])
    end)
  end

  # Discovers which handlers we should use based on existing namespaces.
  # In the end, we reverse the list so we start processing the standard handler
  # first and after that, the handlers that treat feed extensions (itunes, feedburner, etc).
  defp discover_handlers(attrs, default) do
    extensions =
      Enum.reduce(attrs, [default], fn
        {"xmlns:feedburner", @feedburner_namespace}, acc ->
          [Gluttony.Handlers.RSS2Feedburner | acc]

        {"xmlns:itunes", @itunes_namespace}, acc ->
          [Gluttony.Handlers.RSS2Itunes | acc]

        _kv, acc ->
          acc
      end)

    Enum.reverse(extensions)
  end

  # Pushes a tag to the current stack.
  defp push(tag, []), do: [tag]
  defp push(tag, stack), do: [tag | stack]

  # Removes the last tag from the stack.
  defp pop([]), do: []
  defp pop([_head | tail]), do: tail
end
