defmodule Gluttony.Handlers.RSS2Content do
  @moduledoc false

  @behaviour Gluttony.Handler

  @impl true
  def handle_element(attrs, stack) do
    case stack do
      _stack ->
        {:cont, attrs}
    end
  end

  @impl true
  def handle_content(chars, stack) do
    case stack do
      ["content:encoded", "item" | _rest] ->
        {:entry, :content, chars}

      _stack ->
        {:cont, chars}
    end
  end

  @impl true
  def handle_cached(cached, stack) do
    case stack do
      _stack -> {:cont, cached}
    end
  end
end
