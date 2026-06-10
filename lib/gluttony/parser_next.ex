defmodule Gluttony.ParserNext do
  @moduledoc false

  @behaviour Saxy.Handler

  require Logger

  def parse(xml) when is_binary(xml) do
    Saxy.parse_string(xml, __MODULE__, [])
  end

  def handle_event(:start_document, _prolog, _opts) do
    {:ok,
     %{
       stack: [],
       handlers: [
         Gluttony.ParserNext.RSS2Rules,
         Gluttony.ParserNext.RSS2ItunesRules,
         Gluttony.ParserNext.RSS2GoogleplayRules,
         Gluttony.ParserNext.RSS2ContentRules,
         Gluttony.ParserNext.RSS2DCRules,
         Gluttony.ParserNext.RSS2FeedburnerRules
       ],
       content: nil,
       result: %{feed: %{}}
     }}
  end

  def handle_event(:start_element, {name, attrs}, state) do
    {:ok, open_element(state, name, attrs)}
  end

  def handle_event(:characters, chars, state) do
    {:ok, parse_content(String.trim(chars), state)}
  end

  def handle_event(:end_element, name, state) do
    {:ok, close_element(state, name)}
  end

  def handle_event(:end_document, _data, state) do
    {:ok, Map.put(state.result, :type, :rss2)}
  end

  defp open_element(state, name, attrs) do
    Logger.debug("opening element <#{name}>")

    state
    |> push_stack(name)
    |> parse_element()
    |> parse_attributes(attrs)
  end

  defp close_element(state, name) do
    Logger.debug("closing element </#{name}>")

    state
    |> parse_content()
    |> pop_stack()
  end

  defp parse_element(state) do
    invoke_matching_handlers(state, fn handler, state ->
      handler.handle_element(state.stack, state)
    end)
  end

  defp parse_attributes(state, attrs) do
    Enum.reduce(attrs, state, fn attr, state ->
      invoke_matching_handlers(state, fn handler, state ->
        handler.handle_attribute(state.stack, attr, state)
      end)
    end)
  end

  defp parse_content(state) do
    invoke_matching_handlers(state, fn handler, state ->
      handler.handle_content(state.stack, state)
    end)
  end

  defp invoke_matching_handlers(state, callback) do
    Enum.reduce_while(state.handlers, state, fn handler, state ->
      case callback.(handler, state) do
        {:ok, state} -> {:halt, state}
        {:cont, state} -> {:cont, state}
      end
    end)
  end

  defp parse_content("", state), do: state
  defp parse_content(content, %{content: nil} = state), do: %{state | content: content}
  defp parse_content(content, %{content: previous} = state), do: %{state | content: [previous | content]}

  defp pop_stack(%{stack: [_name | stack]} = state), do: %{state | content: nil, stack: stack}
  defp push_stack(%{stack: stack} = state, name), do: %{state | content: nil, stack: [name | stack]}
end
