defmodule Gluttony.Handlers.RSS2Feedburner do
  @behaviour Gluttony.Handler

  # TODO: Find spec and implement the feedburner extension.

  alias Gluttony.Handlers.RSS2Standard

  @impl true
  def handle_element(attrs, stack) do
    RSS2Standard.handle_element(attrs, stack)
  end

  @impl true
  def handle_content(chars, stack) do
    RSS2Standard.handle_content(chars, stack)
  end
end
