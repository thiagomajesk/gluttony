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
  def handle_event(:end_document, _data, {_scopes, feed}) do
    {:ok, feed}
  end

  @doc false
  def handle_event(:start_element, {name, attributes}, {scopes, feed}) do
    feed =
      case {parent(scopes), name} do
        {"rss", "channel"} ->
          %Feed{}

        {"channel", "item"} ->
          Map.update(feed, :items, [], &[%FeedItem{} | &1])

        {"channel", "image"} ->
          Map.put(feed, :image, %{})

        {"channel", "cloud"} ->
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

    {:ok, {stack(name, scopes), feed}}
  end

  @doc false
  def handle_event(:end_element, _name, {scopes, feed}) do
    {:ok, {unstack(scopes), feed}}
  end

  @doc false
  def handle_event(:characters, chars, {scopes, feed}) do
    feed =
      case parent_and_current(scopes) do
        #
        # Required channel elements
        #
        {"channel", "title"} ->
          Map.put(feed, :title, chars)

        {"channel", "link"} ->
          Map.put(feed, :link, chars)

        {"channel", "description"} ->
          Map.put(feed, :description, chars)

        #
        # Optional channel elements
        #
        {"channel", "language"} ->
          Map.put(feed, :language, chars)

        {"channel", "copyright"} ->
          Map.put(feed, :copyright, chars)

        {"channel", "managingEditor"} ->
          Map.put(feed, :managing_editor, chars)

        {"channel", "webMaster"} ->
          Map.put(feed, :web_master, chars)

        {"channel", "pubDate"} ->
          chars = parse_datetime(chars)
          Map.put(feed, :pub_date, chars)

        {"channel", "lastBuildDate"} ->
          chars = parse_datetime(chars)
          Map.put(feed, :last_build_date, chars)

        {"channel", "category"} ->
          Map.update(feed, :categories, [], &[chars | &1])

        {"channel", "generator"} ->
          Map.put(feed, :generator, chars)

        {"channel", "docs"} ->
          Map.put(feed, :docs, chars)

        {"channel", "ttl"} ->
          chars = parse_integer(chars)
          Map.put(feed, :ttl, chars)

        {"channel", "rating"} ->
          Map.put(feed, :rating, chars)

        {"channel", "textInput"} ->
          Map.put(feed, :text_input, chars)

        {"channel", "skipHours"} ->
          Map.put(feed, :skip_hours, chars)

        {"channel", "skipDays"} ->
          Map.put(feed, :skip_days, chars)

        #
        # Feed image elements
        #
        {"image", "url"} ->
          update_feed_image(feed, :url, chars)

        {"image", "title"} ->
          update_feed_image(feed, :title, chars)

        {"image", "link"} ->
          update_feed_image(feed, :link, chars)

        {"image", "width"} ->
          chars = parse_integer(chars)
          update_feed_image(feed, :width, chars)

        {"image", "height"} ->
          chars = parse_integer(chars)
          update_feed_image(feed, :height, chars)

        {"image", "description"} ->
          update_feed_image(feed, :description, chars)

        #
        # Item elements
        #

        {"item", "title"} ->
          update_feed_item(feed, :title, chars)

        {"item", "link"} ->
          update_feed_item(feed, :link, chars)

        {"item", "guid"} ->
          update_feed_item(feed, :guid, chars)

        {"item", "pubDate"} ->
          date = parse_datetime(chars)
          update_feed_item(feed, :pub_date, date)

        {"item", "description"} ->
          cdata = parse_cdata(chars)
          update_feed_item(feed, :description, cdata)

        _ ->
          feed
      end

    {:ok, {scopes, feed}}
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

  # Returns parent tag for :start_document and :end_document.
  defp parent([]), do: nil
  defp parent(scopes), do: hd(scopes)

  # Returns the containing tag and its parent for :characters event.
  defp parent_and_current(scopes) do
    {parent(unstack(scopes)), parent(scopes)}
  end

  # Tracks the hieranchy (scope) of the current tag.
  defp stack(tag, scopes), do: [tag | scopes]
  defp unstack(scopes), do: tl(scopes)
end
