defmodule Gluttony.Parser do
  @moduledoc """
  Deals with XML processing.

  # Remarks
  If CDATA is not getting pickedup, make sure the rss source
  was not processed or formatted in any form. Since we are not using a separate event
  to treat CDATA, we need to make sure there's no newlines between tag and content.
  More information about why this is necessary can be found here: https://github.com/qcam/saxy/issues/98.
  """

  alias Gluttony.State
  @behaviour Saxy.Handler

  @itunes_namespace "http://www.itunes.com/dtds/podcast-1.0.dtd"
  @feedburner_namespace "http://rssnamespace.org/feedburner/ext/1.0"
  @googleplay_namespace "http://www.google.com/schemas/play-podcasts/1.0"
  @atom_namespace "http://www.w3.org/2005/Atom"
  @content_namespace "http://purl.org/rss/1.0/modules/content/"
  @dc_namespace "http://purl.org/dc/elements/1.1/"

  @doc false
  def handle_event(:start_document, _prolog, opts) do
    {:ok, %State{raw: Keyword.get(opts, :raw, true)}}
  end

  @doc false
  def handle_event(:end_document, _data, state) do
    {:ok, State.result(state)}
  end

  @doc false
  def handle_event(:start_element, {name, attributes}, %State{handlers: nil} = state) do
    case {name, Map.new(attributes)} do
      {"rss", %{"version" => "2.0"} = attrs} ->
        handlers = discover_handlers(attrs, Gluttony.Handlers.RSS2Standard)
        {:ok, %{state | handlers: handlers, type: :rss2}}

      {"feed", %{"xmlns" => @atom_namespace}} ->
        {:ok, %{state | handlers: [Gluttony.Handlers.Atom1Standard], type: :atom1}}

      _ ->
        {:halt, "No handler available to parse this feed #{inspect(attributes)}"}
    end
  end

  @doc false
  def handle_event(:start_element, {name, attributes}, %State{handlers: handlers} = state) do
    # Push the current tag early to the stack so the calls
    # to :handle_element and :handle_content can consistently use
    # the stack to find the current scope we are processing.
    state = State.push(state, name)

    {:ok, dispatch_events(handlers, :handle_element, attributes, state)}
  end

  @doc false
  def handle_event(:end_element, name, %{handlers: handlers, cache: cache} = state) do
    {cached, cache} = Map.pop(cache, to_string(name))

    state = dispatch_events(handlers, :handle_cached, cached, state)

    {:ok, %{State.pop(state) | cache: cache}}
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
  defp dispatch_events([], _fun, _content, state), do: state

  defp dispatch_events([handler | handlers], fun, content, state) do
    state = apply(Gluttony.Handler, fun, [handler, content, state])
    dispatch_events(handlers, fun, content, state)
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

        {"xmlns:googleplay", @googleplay_namespace}, acc ->
          [Gluttony.Handlers.RSS2Googleplay | acc]

        {"xmlns:content", @content_namespace}, acc ->
          [Gluttony.Handlers.RSS2Content | acc]

        {"xmlns:dc", @dc_namespace}, acc ->
          [Gluttony.Handlers.RSS2DC | acc]

        _kv, acc ->
          acc
      end)

    Enum.reverse(extensions)
  end
end
