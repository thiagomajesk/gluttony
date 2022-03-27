defmodule Gluttony.Handlers.RSS2Itunes do
  @moduledoc false

  @behaviour Gluttony.Handler

  @impl true
  def handle_element(attrs, stack) do
    case stack do
      ["itunes:owner", "channel"] ->
        {:cache, "itunes:owner"}

      ["itunes:image", "channel"] ->
        attrs = Map.new(attrs)
        {:feed, :itunes_image, attrs["href"]}

      ["itunes:category", "channel"] ->
        attrs = Map.new(attrs)
        {:feed, :itunes_categories, [attrs["text"]]}

      ["itunes:category", "itunes:category", "channel"] ->
        attrs = Map.new(attrs)
        {:feed, :itunes_categories, [attrs["text"]]}

      _ ->
        {:cont, attrs}
    end
  end

  @impl true
  def handle_content(chars, stack) do
    case stack do
      ["itunes:author", "channel"] ->
        {:feed, :itunes_author, chars}

      ["itunes:type", "channel"] ->
        {:feed, :itunes_type, chars}

      ["itunes:name", "itunes:owner", "channel"] ->
        {:cache, ["itunes:owner", :name], chars}

      ["itunes:email", "itunes:owner", "channel"] ->
        {:cache, ["itunes:owner", :email], chars}

      ["itunes:explicit", "channel"] ->
        {:feed, :itunes_explicit, chars}

      ["itunes:episodeType", "item" | _] ->
        {:entry, :itunes_episode_type, chars}

      ["itunes:title", "item" | _] ->
        {:entry, :itunes_title, chars}

      ["itunes:duration", "item" | _] ->
        {:entry, :itunes_duration, chars}

      ["itunes:explicit", "item" | _] ->
        {:entry, :itunes_explicit, chars}

      _ ->
        {:cont, chars}
    end
  end

  @impl true
  def handle_cached(cached, stack) do
    case stack do
      ["itunes:owner", "channel"] ->
        {:feed, :itunes_owner, cached}

      _ ->
        {:cont, cached}
    end
  end
end
