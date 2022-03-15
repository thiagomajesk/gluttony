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

      ["textInput", "channel" | _] ->
        {Map.put(channel, :text_input, %{}), items}

      ["skipDays", "channel" | _] ->
        {Map.put_new(channel, :skip_days, []), items}

      ["skipHours", "channel" | _] ->
        {Map.put_new(channel, :skip_hours, []), items}

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

      ["item", "channel" | _] ->
        {channel, [%{} | items]}

      ["enclosure", "item" | _] ->
        attrs = Map.new(attrs)

        enclosure = %{
          url: attrs["url"],
          length: parse_integer(attrs["length"]),
          type: attrs["type"]
        }

        {channel, put_new_for_current_item(items, :enclosure, enclosure)}

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

      ["hour", "skipHours", "channel" | _] ->
        chars = parse_integer(chars)
        {Map.update!(channel, :skip_hours, &[chars | &1]), items}

      ["day", "skipDays", "channel" | _] ->
        chars =
          chars
          |> String.downcase()
          |> String.to_existing_atom()

        {Map.update!(channel, :skip_days, &[chars | &1]), items}

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
      # Channel textInput element
      #
      ["title", "textInput" | _] ->
        {put_in(channel, [:text_input, :title], chars), items}

      ["description", "textInput" | _] ->
        {put_in(channel, [:text_input, :description], chars), items}

      ["name", "textInput" | _] ->
        {put_in(channel, [:text_input, :name], chars), items}

      ["link", "textInput" | _] ->
        {put_in(channel, [:text_input, :link], chars), items}

      #
      # Item element
      #
      ["title", "item" | _] ->
        {channel, put_new_for_current_item(items, :title, chars)}

      ["link", "item" | _] ->
        {channel, put_new_for_current_item(items, :link, chars)}

      ["guid", "item" | _] ->
        {channel, put_new_for_current_item(items, :guid, chars)}

      ["pubDate", "item" | _] ->
        date = parse_datetime(chars)
        {channel, put_new_for_current_item(items, :pub_date, date)}

      ["description", "item" | _] ->
        cdata = parse_cdata(chars)
        {channel, put_new_for_current_item(items, :description, cdata)}

      ["author", "item" | _] ->
        {channel, put_new_for_current_item(items, :author, chars)}

      ["category", "item" | _] ->
        {channel, append_new_for_current_item(items, :categories, chars)}

      ["comments", "item" | _] ->
        {channel, put_new_for_current_item(items, :comments, chars)}

      ["source", "item" | _] ->
        {channel, put_new_for_current_item(items, :source, chars)}

      _ ->
        {channel, items}
    end
  end

  # Appends a new value to the key for the current item (recently created).
  defp append_new_for_current_item([item | items], key, value) do
    [Map.update(item, key, [value], &[value | &1]) | items]
  end

  # Puts a new value to the key for the current item (recently created).
  defp put_new_for_current_item([item | items], key, value) do
    [Map.put(item, key, value) | items]
  end
end
