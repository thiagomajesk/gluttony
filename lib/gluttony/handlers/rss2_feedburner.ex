defmodule Gluttony.Handlers.RSS2Feedburner do
  @moduledoc false

  @behaviour Gluttony.Handler

  # Pending: find the spec and implement the feedburner extension.

  @impl true
  def handle_element(attrs, stack) do
    case stack do
      _stack -> {:cont, attrs}
    end
  end

  @impl true
  def handle_content(chars, stack) do
    case stack do
      _stack -> {:cont, chars}
    end
  end

  @impl true
  def handle_cached(cached, stack) do
    case stack do
      _stack -> {:cont, cached}
    end
  end
end
