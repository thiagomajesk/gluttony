defmodule Gluttony.Parsers.RSS2 do
  @behaviour Saxy.Handler

  import Gluttony.Parsers.Helpers
  alias Gluttony.{Feed, FeedImage, FeedItem}

  def handle_event(:start_document, _prolog, _state) do
    {:ok, {[], nil}}
  end

  def handle_event(:end_document, _data, {_scopes, feed}) do
    {:ok, feed}
  end

  def handle_event(:start_element, {name, attributes}, {scopes, feed}) do
    feed =
      case {parent(scopes), name} do
        {"rss", "channel"} ->
          %Feed{}

        {"channel", "item"} ->
          items = [%FeedItem{} | feed.items]
          %{feed | items: items}

        {"channel", "image"} ->
          image = %FeedImage{}
          %{feed | image: image}

        {"channel", "cloud"} ->
          cloud = parse_cloud_attributes(attributes)
          %{feed | cloud: cloud}

        _ ->
          feed
      end

    {:ok, {stack(name, scopes), feed}}
  end

  def handle_event(:end_element, _name, {scopes, feed}) do
    {:ok, {unstack(scopes), feed}}
  end

  def handle_event(:characters, chars, {scopes, feed}) do
    feed =
      case parent_and_current(scopes) do
        #
        # Required channel elements
        #
        {"channel", "title"} ->
          %{feed | title: chars}

        {"channel", "link"} ->
          %{feed | link: chars}

        {"channel", "description"} ->
          %{feed | description: chars}

        #
        # Optional channel elements
        #
        {"channel", "language"} ->
          %{feed | language: chars}

        {"channel", "copyright"} ->
          %{feed | copyright: chars}

        {"channel", "managingEditor"} ->
          %{feed | managing_editor: chars}

        {"channel", "webMaster"} ->
          %{feed | web_master: chars}

        {"channel", "pubDate"} ->
          date = parse_datetime(chars)
          %{feed | pub_date: date}

        {"channel", "lastBuildDate"} ->
          date = parse_datetime(chars)
          %{feed | last_build_date: date}

        {"channel", "category"} ->
          categories = [chars | feed.categories]
          %{feed | categories: categories}

        {"channel", "generator"} ->
          %{feed | generator: chars}

        {"channel", "docs"} ->
          %{feed | docs: chars}

        {"channel", "ttl"} ->
          %{feed | ttl: parse_integer(chars)}

        {"channel", "rating"} ->
          %{feed | rating: chars}

        {"channel", "textInput"} ->
          %{feed | text_input: chars}

        {"channel", "skipHours"} ->
          %{feed | skip_hours: chars}

        {"channel", "skipDays"} ->
          %{feed | skip_days: chars}

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
          width = parse_integer(chars)
          update_feed_image(feed, :width, width)

        {"image", "height"} ->
          height = parse_integer(chars)
          update_feed_image(feed, :height, height)

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
