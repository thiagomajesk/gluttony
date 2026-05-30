# credo:disable-for-this-file Credo.Check.Refactor.CyclomaticComplexity
defmodule Gluttony.Handlers.RSS2Standard do
  @moduledoc false

  @behaviour Gluttony.Handler

  @impl true
  def handle_element(attrs, stack) do
    case stack do
      ["item", "channel" | _rest] ->
        {:entry, attrs}

      ["cloud", "channel" | _rest] ->
        attrs = Map.new(attrs)

        cloud = %{
          domain: attrs["domain"],
          port: attrs["port"],
          path: attrs["path"],
          register_procedure: attrs["registerProcedure"],
          protocol: attrs["protocol"]
        }

        {:feed, :cloud, cloud}

      ["enclosure", "item" | _rest] ->
        attrs = Map.new(attrs)

        enclosure = %{
          url: attrs["url"],
          length: attrs["length"],
          type: attrs["type"]
        }

        {:entry, :enclosure, enclosure}

      _stack ->
        {:cont, attrs}
    end
  end

  @impl true
  def handle_content(chars, stack) do
    case stack do
      #
      # Required channel elements
      #
      ["title", "channel" | _rest] ->
        {:feed, :title, chars}

      ["link", "channel" | _rest] ->
        {:feed, :link, chars}

      ["description", "channel" | _rest] ->
        {:feed, :description, chars}

      #
      # Optional channel elements
      #
      ["language", "channel" | _rest] ->
        {:feed, :language, chars}

      ["copyright", "channel" | _rest] ->
        {:feed, :copyright, chars}

      ["managingEditor", "channel" | _rest] ->
        {:feed, :managing_editor, chars}

      ["webMaster", "channel" | _rest] ->
        {:feed, :web_master, chars}

      ["pubDate", "channel" | _rest] ->
        {:feed, :pub_date, chars}

      ["lastBuildDate", "channel" | _rest] ->
        {:feed, :last_build_date, chars}

      ["category", "channel" | _rest] ->
        {:feed, :categories, [chars]}

      ["generator", "channel" | _rest] ->
        {:feed, :generator, chars}

      ["docs", "channel" | _rest] ->
        {:feed, :docs, chars}

      ["ttl", "channel" | _rest] ->
        {:feed, :ttl, chars}

      ["rating", "channel" | _rest] ->
        {:feed, :rating, chars}

      ["hour", "skipHours", "channel" | _rest] ->
        {:feed, :skip_hours, [chars]}

      ["day", "skipDays", "channel" | _rest] ->
        {:feed, :skip_days, [chars]}

      #
      # channel image elements
      #
      ["url", "image" | _rest] ->
        {:feed, [:image, :url], chars}

      ["title", "image" | _rest] ->
        {:feed, [:image, :title], chars}

      ["link", "image" | _rest] ->
        {:feed, [:image, :link], chars}

      ["width", "image" | _rest] ->
        {:feed, [:image, :width], chars}

      ["height", "image" | _rest] ->
        {:feed, [:image, :height], chars}

      ["description", "image" | _rest] ->
        {:feed, [:image, :description], chars}

      #
      # Channel textInput element
      #
      ["title", "textInput" | _rest] ->
        {:feed, [:text_input, :title], chars}

      ["description", "textInput" | _rest] ->
        {:feed, [:text_input, :description], chars}

      ["name", "textInput" | _rest] ->
        {:feed, [:text_input, :name], chars}

      ["link", "textInput" | _rest] ->
        {:feed, [:text_input, :link], chars}

      #
      # Item element
      #
      ["title", "item" | _rest] ->
        {:entry, :title, chars}

      ["link", "item" | _rest] ->
        {:entry, :link, chars}

      ["guid", "item" | _rest] ->
        {:entry, :guid, chars}

      ["pubDate", "item" | _rest] ->
        {:entry, :pub_date, chars}

      ["description", "item" | _rest] ->
        {:entry, :description, chars}

      ["author", "item" | _rest] ->
        {:entry, :author, chars}

      ["category", "item" | _rest] ->
        {:entry, :categories, [chars]}

      ["comments", "item" | _rest] ->
        {:entry, :comments, chars}

      ["source", "item" | _rest] ->
        {:entry, :source, chars}

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
