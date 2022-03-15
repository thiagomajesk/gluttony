defmodule Gluttony.Handlers.RSS2Standard do
  import Gluttony.Helpers

  def handle_element({feed, entries}, attrs, stack) do
    case stack do
      ["channel" | _] ->
        {%{}, entries}

      ["image", "channel" | _] ->
        {Map.put(feed, :image, %{}), entries}

      ["category", "channel" | _] ->
        {Map.put_new(feed, :categories, []), entries}

      ["textInput", "channel" | _] ->
        {Map.put(feed, :text_input, %{}), entries}

      ["skipDays", "channel" | _] ->
        {Map.put_new(feed, :skip_days, []), entries}

      ["skipHours", "channel" | _] ->
        {Map.put_new(feed, :skip_hours, []), entries}

      ["cloud", "channel" | _] ->
        attrs = Map.new(attrs)

        feed =
          Map.put(feed, :cloud, %{
            domain: attrs["domain"],
            port: parse_integer(attrs["port"]),
            path: attrs["path"],
            register_procedure: attrs["registerProcedure"],
            protocol: attrs["protocol"]
          })

        {feed, entries}

      ["item", "channel" | _] ->
        {feed, [%{} | entries]}

      ["enclosure", "item" | _] ->
        attrs = Map.new(attrs)

        enclosure = %{
          url: attrs["url"],
          length: parse_integer(attrs["length"]),
          type: attrs["type"]
        }

        {feed, put_into_current_entry(entries, :enclosure, enclosure)}

      _ ->
        {feed, entries}
    end
  end

  def handle_content({feed, entries}, chars, stack) do
    case stack do
      #
      # Required channel elements
      #
      ["title", "channel" | _] ->
        {Map.put(feed, :title, chars), entries}

      ["link", "channel" | _] ->
        {Map.put(feed, :link, chars), entries}

      ["description", "channel" | _] ->
        {Map.put(feed, :description, chars), entries}

      #
      # Optional channel elements
      #
      ["language", "channel" | _] ->
        {Map.put(feed, :language, chars), entries}

      ["copyright", "channel" | _] ->
        {Map.put(feed, :copyright, chars), entries}

      ["managingEditor", "channel" | _] ->
        {Map.put(feed, :managing_editor, chars), entries}

      ["webMaster", "channel" | _] ->
        {Map.put(feed, :web_master, chars), entries}

      ["pubDate", "channel" | _] ->
        chars = parse_datetime(chars)
        {Map.put(feed, :pub_date, chars), entries}

      ["lastBuildDate", "channel" | _] ->
        chars = parse_datetime(chars)
        {Map.put(feed, :last_build_date, chars), entries}

      ["category", "channel" | _] ->
        {Map.update(feed, :categories, [], &[chars | &1]), entries}

      ["generator", "channel" | _] ->
        {Map.put(feed, :generator, chars), entries}

      ["docs", "channel" | _] ->
        {Map.put(feed, :docs, chars), entries}

      ["ttl", "channel" | _] ->
        chars = parse_integer(chars)
        {Map.put(feed, :ttl, chars), entries}

      ["rating", "channel" | _] ->
        {Map.put(feed, :rating, chars), entries}

      ["hour", "skipHours", "channel" | _] ->
        chars = parse_integer(chars)
        {Map.update!(feed, :skip_hours, &[chars | &1]), entries}

      ["day", "skipDays", "channel" | _] ->
        chars =
          chars
          |> String.downcase()
          |> String.to_existing_atom()

        {Map.update!(feed, :skip_days, &[chars | &1]), entries}

      #
      # channel image elements
      #
      ["url", "image" | _] ->
        {put_in(feed, [:image, :url], chars), entries}

      ["title", "image" | _] ->
        {put_in(feed, [:image, :title], chars), entries}

      ["link", "image" | _] ->
        {put_in(feed, [:image, :link], chars), entries}

      ["width", "image" | _] ->
        chars = parse_integer(chars)
        {put_in(feed, [:image, :width], chars), entries}

      ["height", "image" | _] ->
        chars = parse_integer(chars)
        {put_in(feed, [:image, :height], chars), entries}

      ["description", "image" | _] ->
        {put_in(feed, [:image, :description], chars), entries}

      #
      # Channel textInput element
      #
      ["title", "textInput" | _] ->
        {put_in(feed, [:text_input, :title], chars), entries}

      ["description", "textInput" | _] ->
        {put_in(feed, [:text_input, :description], chars), entries}

      ["name", "textInput" | _] ->
        {put_in(feed, [:text_input, :name], chars), entries}

      ["link", "textInput" | _] ->
        {put_in(feed, [:text_input, :link], chars), entries}

      #
      # Item element
      #
      ["title", "item" | _] ->
        {feed, put_into_current_entry(entries, :title, chars)}

      ["link", "item" | _] ->
        {feed, put_into_current_entry(entries, :link, chars)}

      ["guid", "item" | _] ->
        {feed, put_into_current_entry(entries, :guid, chars)}

      ["pubDate", "item" | _] ->
        date = parse_datetime(chars)
        {feed, put_into_current_entry(entries, :pub_date, date)}

      ["description", "item" | _] ->
        cdata = parse_cdata(chars)
        {feed, put_into_current_entry(entries, :description, cdata)}

      ["author", "item" | _] ->
        {feed, put_into_current_entry(entries, :author, chars)}

      ["category", "item" | _] ->
        {feed, append_into_current_entry(entries, :categories, chars)}

      ["comments", "item" | _] ->
        {feed, put_into_current_entry(entries, :comments, chars)}

      ["source", "item" | _] ->
        {feed, put_into_current_entry(entries, :source, chars)}

      _ ->
        {feed, entries}
    end
  end

  # Appends a new value to the key for the current entry (recently created).
  defp append_into_current_entry([entry | entries], key, value) do
    [Map.update(entry, key, [value], &[value | &1]) | entries]
  end

  # Puts a new value to the key for the current entry (recently created).
  defp put_into_current_entry([entry | entries], key, value) do
    [Map.put(entry, key, value) | entries]
  end
end
