defmodule Gluttony.Handlers.RSS2Itunes do
  # call default rss2_standard when there's no match

  def handle_element({channel, items}, attrs, stack) do
    {%{}, %{}}
  end

  def handle_content({channel, items}, chars, stack) do
    {%{}, %{}}
  end
end
