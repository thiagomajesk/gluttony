defmodule Gluttony.Handlers.RSS2Googleplay do
  @moduledoc false

  @behaviour Gluttony.Handler

  @impl true
  def handle_element(attrs, stack) do
    case stack do
      ["googleplay:image", "channel"] ->
        attrs = Map.new(attrs)
        {:feed, :googleplay_image, attrs["href"]}

      ["googleplay:category", "channel"] ->
        attrs = Map.new(attrs)
        {:feed, :googleplay_categories, [attrs["text"]]}

      ["googleplay:image", "item", "channel"] ->
        attrs = Map.new(attrs)
        {:entry, :googleplay_image, attrs["href"]}

      _ ->
        {:cont, attrs}
    end
  end

  @impl true
  def handle_content(chars, stack) do
    case stack do
      ["googleplay:author", "channel"] ->
        {:feed, :googleplay_author, chars}

      ["googleplay:description", "channel"] ->
        {:feed, :googleplay_description, chars}

      ["googleplay:email", "channel"] ->
        {:feed, :googleplay_email, chars}

      ["googleplay:author", "item", "channel"] ->
        {:entry, :googleplay_author, chars}

      ["googleplay:description", "item", "channel"] ->
        {:entry, :googleplay_description, chars}

      _ ->
        {:cont, chars}
    end
  end

  @impl true
  def handle_cached(cached, stack) do
    case stack do
      _ ->
        {:cont, cached}
    end
  end
end
