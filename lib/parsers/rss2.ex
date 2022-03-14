defmodule Gluttony.Parsers.RSS2 do
  @behaviour Saxy.Handler

  import Gluttony.Parsers.Helpers
  alias Gluttony.{Feed, FeedCloud, FeedImage, FeedItem}

  def handle_event(:start_document, _prolog, _state) do
    {:ok, {[], nil}}
  end

  def handle_event(:end_document, _data, {_scopes, feed}) do
    {:ok, feed}
  end

  def handle_event(:start_element, {name, attributes}, {scopes, feed}) do
    case {parent(scopes), name} do
      {"rss", "channel"} ->
        feed = %Feed{}
        {:ok, {stack(name, scopes), feed}}

      {"channel", "item"} ->
        items = [%FeedItem{} | feed.items]
        feed = %{feed | items: items}
        {:ok, {stack(name, scopes), feed}}

      {"channel", "image"} ->
        image = %FeedImage{}
        feed = %{feed | image: image}
        {:ok, {stack(name, scopes), feed}}

      {"channel", "cloud"} ->
        cloud = parse_cloud_attributes(attributes)
        feed = %{feed | cloud: cloud}
        {:ok, {stack(name, scopes), feed}}

      _ ->
        {:ok, {stack(name, scopes), feed}}
    end
  end

  def handle_event(:end_element, _name, {scopes, feed}) do
    {:ok, {unstack(scopes), feed}}
  end

  def handle_event(:characters, chars, {scopes, feed}) do
    case parent_and_current(scopes) do
      #
      # Required channel elements
      #
      {"channel", "title"} ->
        feed = %{feed | title: chars}
        {:ok, {scopes, feed}}

      {"channel", "link"} ->
        feed = %{feed | link: chars}
        {:ok, {scopes, feed}}

      {"channel", "description"} ->
        feed = %{feed | description: chars}
        {:ok, {scopes, feed}}

      #
      # Optional channel elements
      #
      {"channel", "language"} ->
        feed = %{feed | language: chars}
        {:ok, {scopes, feed}}

      {"channel", "copyright"} ->
        feed = %{feed | copyright: chars}
        {:ok, {scopes, feed}}

      {"channel", "managingEditor"} ->
        feed = %{feed | managing_editor: chars}
        {:ok, {scopes, feed}}

      {"channel", "webMaster"} ->
        feed = %{feed | web_master: chars}
        {:ok, {scopes, feed}}

      {"channel", "pubDate"} ->
        date = parse_datetime(chars)
        feed = %{feed | pub_date: date}
        {:ok, {scopes, feed}}

      {"channel", "lastBuildDate"} ->
        date = parse_datetime(chars)
        feed = %{feed | last_build_date: date}
        {:ok, {scopes, feed}}

      {"channel", "category"} ->
        categories = [chars | feed.categories]
        feed = %{feed | categories: categories}
        {:ok, {scopes, feed}}

      {"channel", "generator"} ->
        feed = %{feed | generator: chars}
        {:ok, {scopes, feed}}

      {"channel", "docs"} ->
        feed = %{feed | docs: chars}
        {:ok, {scopes, feed}}

      {"channel", "ttl"} ->
        feed = %{feed | ttl: parse_integer(chars)}
        {:ok, {scopes, feed}}

      {"channel", "rating"} ->
        feed = %{feed | rating: chars}
        {:ok, {scopes, feed}}

      {"channel", "textInput"} ->
        feed = %{feed | text_input: chars}
        {:ok, {scopes, feed}}

      {"channel", "skipHours"} ->
        feed = %{feed | skip_hours: chars}
        {:ok, {scopes, feed}}

      {"channel", "skipDays"} ->
        feed = %{feed | skip_days: chars}
        {:ok, {scopes, feed}}

      #
      # Feed image elements
      #
      {"image", "url"} ->
        feed = update_feed_image(feed, :url, chars)
        {:ok, {scopes, feed}}

      {"image", "title"} ->
        feed = update_feed_image(feed, :title, chars)
        {:ok, {scopes, feed}}

      {"image", "link"} ->
        feed = update_feed_image(feed, :link, chars)
        {:ok, {scopes, feed}}

      {"image", "width"} ->
        width = parse_integer(chars)
        feed = update_feed_image(feed, :width, width)
        {:ok, {scopes, feed}}

      {"image", "height"} ->
        height = parse_integer(chars)
        feed = update_feed_image(feed, :height, height)
        {:ok, {scopes, feed}}

      {"image", "description"} ->
        feed = update_feed_image(feed, :description, chars)
        {:ok, {scopes, feed}}

      #
      # Item elements
      #

      {"item", "title"} ->
        feed = update_feed_item(feed, :title, chars)
        {:ok, {scopes, feed}}

      {"item", "link"} ->
        feed = update_feed_item(feed, :link, chars)
        {:ok, {scopes, feed}}

      {"item", "guid"} ->
        feed = update_feed_item(feed, :guid, chars)
        {:ok, {scopes, feed}}

      {"item", "pubDate"} ->
        date = parse_datetime(chars)
        feed = update_feed_item(feed, :pub_date, date)
        {:ok, {scopes, feed}}

      {"item", "description"} ->
        cdata = parse_cdata(chars)
        feed = update_feed_item(feed, :description, cdata)
        {:ok, {scopes, feed}}

      _ ->
        {:ok, {scopes, feed}}
    end
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
