defmodule Gluttony.Handlers.RSS2Standard do
  import Gluttony.Helpers

  def handle_element({channel, items}, attrs, stack) do
    case stack do
      ["channel" | _] ->
        {%{}, items}

      ["image", "channel" | _] ->
        {Map.put(channel, :image, %{}), items}

      ["category", "channel" | _] ->
        {Map.put_new(channel, :categories, []), items}

      ["cloud", "channel" | _] ->
        attrs = Map.new(attrs)

        channel =
          Map.put(channel, :cloud, %{
            domain: attrs["domain"],
            port: parse_integer(attrs["port"]),
            path: attrs["path"],
            register_procedure: attrs["registerProcedure"],
            protocol: attrs["protocol"]
          })

        {channel, items}

      ["item", "channel", "rss"] ->
        {channel, [%{} | items]}

      _ ->
        {channel, items}
    end
  end

  def handle_content({channel, items}, chars, stack) do
    case stack do
      #
      # Required channel elements
      #
      ["title", "channel" | _] ->
        {Map.put(channel, :title, chars), items}

      ["link", "channel" | _] ->
        {Map.put(channel, :link, chars), items}

      ["description", "channel" | _] ->
        {Map.put(channel, :description, chars), items}

      #
      # Optional channel elements
      #
      ["language", "channel" | _] ->
        {Map.put(channel, :language, chars), items}

      ["copyright", "channel" | _] ->
        {Map.put(channel, :copyright, chars), items}

      ["managingEditor", "channel" | _] ->
        {Map.put(channel, :managing_editor, chars), items}

      ["webMaster", "channel" | _] ->
        {Map.put(channel, :web_master, chars), items}

      ["pubDate", "channel" | _] ->
        chars = parse_datetime(chars)
        {Map.put(channel, :pub_date, chars), items}

      ["lastBuildDate", "channel" | _] ->
        chars = parse_datetime(chars)
        {Map.put(channel, :last_build_date, chars), items}

      ["category", "channel" | _] ->
        {Map.update(channel, :categories, [], &[chars | &1]), items}

      ["generator", "channel" | _] ->
        {Map.put(channel, :generator, chars), items}

      ["docs", "channel" | _] ->
        {Map.put(channel, :docs, chars), items}

      ["ttl", "channel" | _] ->
        chars = parse_integer(chars)
        {Map.put(channel, :ttl, chars), items}

      ["rating", "channel" | _] ->
        {Map.put(channel, :rating, chars), items}

      ["textInput", "channel" | _] ->
        {Map.put(channel, :text_input, chars), items}

      ["skipHours", "channel" | _] ->
        {Map.put(channel, :skip_hours, chars), items}

      ["skipDays", "channel" | _] ->
        {Map.put(channel, :skip_days, chars), items}

      #
      # channel image elements
      #
      ["url", "image" | _] ->
        {put_in(channel, [:image, :url], chars), items}

      ["title", "image" | _] ->
        {put_in(channel, [:image, :title], chars), items}

      ["link", "image" | _] ->
        {put_in(channel, [:image, :link], chars), items}

      ["width", "image" | _] ->
        chars = parse_integer(chars)
        {put_in(channel, [:image, :width], chars), items}

      ["height", "image" | _] ->
        chars = parse_integer(chars)
        {put_in(channel, [:image, :height], chars), items}

      ["description", "image" | _] ->
        {put_in(channel, [:image, :description], chars), items}

      #
      # Item elements
      #
      ["title", "item" | _] ->
        {channel, update_item(channel, :title, chars)}

      ["link", "item" | _] ->
        {channel, update_item(channel, :link, chars)}

      ["guid", "item" | _] ->
        {channel, update_item(channel, :guid, chars)}

      ["pubDate", "item" | _] ->
        date = parse_datetime(chars)
        {channel, update_item(channel, :pub_date, date)}

      ["description", "item" | _] ->
        cdata = parse_cdata(chars)
        {channel, update_item(channel, :description, cdata)}

      _ ->
        {channel, items}
    end
  end

  # Updates the most recent item (first one) added to the list.
  defp update_item(channel, key, value) do
    Map.update(channel, :items, [], fn items ->
      [item | items] = items
      [Map.put(item, key, value) | items]
    end)
  end
end
