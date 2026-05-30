defmodule Gluttony.Handlers.RSS2Content do
  @moduledoc false

  @behaviour Gluttony.Handler

  @impl true
  def handle_element(attrs, stack) do
    case stack do
      _ ->
        {:cont, attrs}
    end
  end

  @impl true
  def handle_content(chars, stack) do
    case stack do
      ["content:encoded", "item" | _] ->
        {:entry, :content, chars}

      _ ->
        {:cont, chars}
    end
  end

  @impl true
  def handle_cached(cached, stack) do
    case stack do
      _ -> {:cont, cached}
    end
  end
end
