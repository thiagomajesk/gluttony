defmodule Gluttony.Handlers.RSS2Standard do
  import Gluttony.Helpers

  def handle_element(attrs, stack) do
    case stack do
      ["item", "channel" | _] ->
        {:entry, attrs}

      ["cloud", "channel" | _] ->
        attrs = Map.new(attrs)

        cloud = %{
          domain: attrs["domain"],
          port: parse_integer(attrs["port"]),
          path: attrs["path"],
          register_procedure: attrs["registerProcedure"],
          protocol: attrs["protocol"]
        }

        {:feed, :cloud, cloud}

      ["enclosure", "item" | _] ->
        attrs = Map.new(attrs)

        enclosure = %{
          url: attrs["url"],
          length: parse_integer(attrs["length"]),
          type: attrs["type"]
        }

        {:entry, :enclosure, enclosure}

      _ ->
        {:cont, attrs}
    end
  end

  def handle_content(chars, stack) do
    case stack do
      #
      # Required channel elements
      #
      ["title", "channel" | _] ->
        {:feed, :title, chars}

      ["link", "channel" | _] ->
        {:feed, :link, chars}

      ["description", "channel" | _] ->
        {:feed, :description, chars}

      #
      # Optional channel elements
      #
      ["language", "channel" | _] ->
        {:feed, :language, chars}

      ["copyright", "channel" | _] ->
        {:feed, :copyright, chars}

      ["managingEditor", "channel" | _] ->
        {:feed, :managing_editor, chars}

      ["webMaster", "channel" | _] ->
        {:feed, :web_master, chars}

      ["pubDate", "channel" | _] ->
        chars = parse_datetime(chars)
        {:feed, :pub_date, chars}

      ["lastBuildDate", "channel" | _] ->
        chars = parse_datetime(chars)
        {:feed, :last_build_date, chars}

      ["category", "channel" | _] ->
        {:feed, :categories, [chars]}

      ["generator", "channel" | _] ->
        {:feed, :generator, chars}

      ["docs", "channel" | _] ->
        {:feed, :docs, chars}

      ["ttl", "channel" | _] ->
        chars = parse_integer(chars)
        {:feed, :ttl, chars}

      ["rating", "channel" | _] ->
        {:feed, :rating, chars}

      ["hour", "skipHours", "channel" | _] ->
        chars = parse_integer(chars)
        {:feed, :skip_hours, [chars]}

      ["day", "skipDays", "channel" | _] ->
        chars =
          chars
          |> String.downcase()
          |> String.to_existing_atom()

        {:feed, :skip_days, [chars]}

      #
      # channel image elements
      #
      ["url", "image" | _] ->
        {:feed, [:image, :url], chars}

      ["title", "image" | _] ->
        {:feed, [:image, :title], chars}

      ["link", "image" | _] ->
        {:feed, [:image, :link], chars}

      ["width", "image" | _] ->
        chars = parse_integer(chars)
        {:feed, [:image, :width], chars}

      ["height", "image" | _] ->
        chars = parse_integer(chars)
        {:feed, [:image, :height], chars}

      ["description", "image" | _] ->
        {:feed, [:image, :description], chars}

      #
      # Channel textInput element
      #
      ["title", "textInput" | _] ->
        {:feed, [:text_input, :title], chars}

      ["description", "textInput" | _] ->
        {:feed, [:text_input, :description], chars}

      ["name", "textInput" | _] ->
        {:feed, [:text_input, :name], chars}

      ["link", "textInput" | _] ->
        {:feed, [:text_input, :link], chars}

      #
      # Item element
      #
      ["title", "item" | _] ->
        {:entry, :title, chars}

      ["link", "item" | _] ->
        {:entry, :link, chars}

      ["guid", "item" | _] ->
        {:entry, :guid, chars}

      ["pubDate", "item" | _] ->
        date = parse_datetime(chars)
        {:entry, :pub_date, date}

      ["description", "item" | _] ->
        cdata = parse_cdata(chars)
        {:entry, :description, cdata}

      ["author", "item" | _] ->
        {:entry, :author, chars}

      ["category", "item" | _] ->
        {:entry, :categories, [chars]}

      ["comments", "item" | _] ->
        {:entry, :comments, chars}

      ["source", "item" | _] ->
        {:entry, :source, chars}

      _ ->
        {:cont, chars}
    end
  end
end
