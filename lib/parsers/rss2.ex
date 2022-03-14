defmodule Gluttony.Parsers.RSS2 do
  @behaviour Saxy.Handler

  import Gluttony.Parsers.Helpers
  alias Gluttony.{Feed, FeedItem}

  @doc """
  Parses the given xml string into a `%Feed{}` struct.
  """
  def parse_string(xml) do
    case Saxy.parse_string(xml, __MODULE__, nil) do
      {:ok, feed} -> feed
      _ -> nil
    end
  end

  @doc false
  def handle_event(:start_document, _prolog, _state) do
    {:ok, {[], nil}}
  end

  @doc false
  def handle_event(:end_document, _data, {_stack, feed}) do
    {:ok, feed}
  end

  @doc false
  def handle_event(:start_element, {name, attributes}, {stack, feed}) do
    stack = push(name, stack)

    feed =
      case stack do
        ["channel", "rss"] ->
          %Feed{}

        ["item", "channel", "rss"] ->
          Map.update(feed, :items, [], &[%FeedItem{} | &1])

        ["image", "channel", "rss"] ->
          Map.put(feed, :image, %{})

        ["cloud", "channel", "rss"] ->
          attrs = Map.new(attributes)

          Map.put(feed, :cloud, %{
            domain: attrs["domain"],
            port: parse_integer(attrs["port"]),
            path: attrs["path"],
            register_procedure: attrs["registerProcedure"],
            protocol: attrs["protocol"]
          })

        _ ->
          feed
      end

    {:ok, {stack, feed}}
  end

  @doc false
  def handle_event(:end_element, _name, {stack, feed}) do
    {:ok, {pop(stack), feed}}
  end

  @doc false
  def handle_event(:characters, chars, {stack, feed}) do
    feed =
      case stack do
        #
        # Required channel elements
        #
        ["title", "channel" | _] ->
          Map.put(feed, :title, chars)

        ["link", "channel" | _] ->
          Map.put(feed, :link, chars)

        ["description", "channel" | _] ->
          Map.put(feed, :description, chars)

        #
        # Optional channel elements
        #
        ["language", "channel" | _] ->
          Map.put(feed, :language, chars)

        ["copyright", "channel" | _] ->
          Map.put(feed, :copyright, chars)

        ["managingEditor", "channel" | _] ->
          Map.put(feed, :managing_editor, chars)

        ["webMaster", "channel" | _] ->
          Map.put(feed, :web_master, chars)

        ["pubDate", "channel" | _] ->
          chars = parse_datetime(chars)
          Map.put(feed, :pub_date, chars)

        ["lastBuildDate", "channel" | _] ->
          chars = parse_datetime(chars)
          Map.put(feed, :last_build_date, chars)

        ["category", "channel" | _] ->
          Map.update(feed, :categories, [], &[chars | &1])

        ["generator", "channel" | _] ->
          Map.put(feed, :generator, chars)

        ["docs", "channel" | _] ->
          Map.put(feed, :docs, chars)

        ["ttl", "channel" | _] ->
          chars = parse_integer(chars)
          Map.put(feed, :ttl, chars)

        ["rating", "channel" | _] ->
          Map.put(feed, :rating, chars)

        ["textInput", "channel" | _] ->
          Map.put(feed, :text_input, chars)

        ["skipHours", "channel" | _] ->
          Map.put(feed, :skip_hours, chars)

        ["skipDays", "channel" | _] ->
          Map.put(feed, :skip_days, chars)

        #
        # Feed image elements
        #
        ["url", "image" | _] ->
          update_feed_image(feed, :url, chars)

        ["title", "image" | _] ->
          update_feed_image(feed, :title, chars)

        ["link", "image" | _] ->
          update_feed_image(feed, :link, chars)

        ["width", "image" | _] ->
          chars = parse_integer(chars)
          update_feed_image(feed, :width, chars)

        ["height", "image" | _] ->
          chars = parse_integer(chars)
          update_feed_image(feed, :height, chars)

        ["description", "image" | _] ->
          update_feed_image(feed, :description, chars)

        #
        # Item elements
        #

        ["title", "item" | _] ->
          update_feed_item(feed, :title, chars)

        ["link", "item" | _] ->
          update_feed_item(feed, :link, chars)

        ["guid", "item" | _] ->
          update_feed_item(feed, :guid, chars)

        ["pubDate", "item" | _] ->
          date = parse_datetime(chars)
          update_feed_item(feed, :pub_date, date)

        ["description", "item" | _] ->
          cdata = parse_cdata(chars)
          update_feed_item(feed, :description, cdata)

        _ ->
          feed
      end

    {:ok, {stack, feed}}
  end

  # Updates the most recent feed item (first one) added to the list.
  defp update_feed_item(feed, key, value) do
    Map.update(feed, :items, [], fn items ->
      [item | items] = items
      [Map.put(item, key, value) | items]
    end)
  end

  # Updates the feed image struct with the given key and value.
  defp update_feed_image(feed, key, value) do
    Map.update(feed, :image, nil, &Map.put(&1, key, value))
  end

  # Pushes a tag to the current hierachy.
  defp push(tag, []), do: [tag]
  defp push(tag, stack), do: [tag | stack]

  # Removes the last tag from the current hierachy.
  defp pop([]), do: []
  defp pop(stack), do: tl(stack)
end
