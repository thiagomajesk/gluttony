defmodule Gluttony.Parsers.RSS2 do
  @behaviour Saxy.Handler

  defmodule Feed do
    defstruct [
      :title,
      :link,
      :description,
      :language,
      :copyright,
      :managing_editor,
      :web_master,
      :pub_date,
      :last_build_date,
      :generator,
      :docs,
      :cloud,
      :ttl,
      :image,
      :rating,
      :text_input,
      :skip_hours,
      :skip_days,
      categories: [],
      items: []
    ]
  end

  defmodule FeedImage do
    defstruct [:url, :title, :link, :width, :height, :description]
  end

  defmodule FeedCloud do
    defstruct [:domain, :port, :path, :register_procedure, :protocol]
  end

  defmodule FeedItem do
    defstruct [:title, :link, :guid, :pub_date, :description]
  end

  def handle_event(:start_document, _prolog, _state) do
    {:ok, {nil, nil, nil}}
  end

  def handle_event(:end_document, _data, {_current_tag, _scope, feed}) do
    {:ok, feed}
  end

  def handle_event(:start_element, {name, attributes}, {_current_tag, scope, feed}) do
    case {scope, name} do
      {_, "channel"} ->
        feed = %Feed{}
        {:ok, {name, :feed, feed}}

      {_, "item"} ->
        items = [%FeedItem{} | feed.items]
        feed = %{feed | items: items}
        {:ok, {name, :feed_item, feed}}

      {:feed, "image"} ->
        image = %FeedImage{}
        feed = %{feed | image: image}
        {:ok, {name, :feed_image, feed}}

      {:feed, "cloud"} ->
        cloud = parse_cloud_attributes(attributes)
        feed = %{feed | cloud: cloud}
        {:ok, {name, scope, feed}}

      _ ->
        {:ok, {name, scope, feed}}
    end
  end

  def handle_event(:end_element, _name, state) do
    {:ok, state}
  end

  def handle_event(:characters, chars, {current_tag, scope, feed}) do
    case {scope, current_tag} do
      #
      # Required channel elements
      #
      {:feed, "title"} ->
        feed = %{feed | title: chars}
        {:ok, {"channel", scope, feed}}

      {:feed, "link"} ->
        feed = %{feed | link: chars}
        {:ok, {"channel", scope, feed}}

      {:feed, "description"} ->
        feed = %{feed | description: chars}
        {:ok, {"channel", scope, feed}}

      #
      # Optional channel elements
      #
      {:feed, "language"} ->
        feed = %{feed | language: chars}
        {:ok, {"channel", scope, feed}}

      {:feed, "copyright"} ->
        feed = %{feed | copyright: chars}
        {:ok, {"channel", scope, feed}}

      {:feed, "managingEditor"} ->
        feed = %{feed | managing_editor: chars}
        {:ok, {"channel", scope, feed}}

      {:feed, "webMaster"} ->
        feed = %{feed | web_master: chars}
        {:ok, {"channel", scope, feed}}

      {:feed, "pubDate"} ->
        date = parse_datetime(chars)
        feed = %{feed | pub_date: date}
        {:ok, {"channel", scope, feed}}

      {:feed, "lastBuildDate"} ->
        date = parse_datetime(chars)
        feed = %{feed | last_build_date: date}
        {:ok, {"channel", scope, feed}}

      {:feed, "category"} ->
        categories = [chars | feed.categories]
        feed = %{feed | categories: categories}
        {:ok, {"channel", scope, feed}}

      {:feed, "generator"} ->
        feed = %{feed | generator: chars}
        {:ok, {"channel", scope, feed}}

      {:feed, "docs"} ->
        feed = %{feed | docs: chars}
        {:ok, {"channel", scope, feed}}

      {:feed, "ttl"} ->
        feed = %{feed | ttl: parse_integer(chars)}
        {:ok, {"channel", scope, feed}}

      {:feed, "rating"} ->
        feed = %{feed | rating: chars}
        {:ok, {"channel", scope, feed}}

      {:feed, "textInput"} ->
        feed = %{feed | text_input: chars}
        {:ok, {"channel", scope, feed}}

      {:feed, "skipHours"} ->
        feed = %{feed | skip_hours: chars}
        {:ok, {"channel", scope, feed}}

      {:feed, "skipDays"} ->
        feed = %{feed | skip_days: chars}
        {:ok, {"channel", scope, feed}}

      #
      # Feed image elements
      #
      {:feed_image, "url"} ->
        feed = update_feed_image(feed, :url, chars)
        {:ok, {"channel", scope, feed}}

      {:feed_image, "title"} ->
        feed = update_feed_image(feed, :title, chars)
        {:ok, {"channel", scope, feed}}

      {:feed_image, "link"} ->
        feed = update_feed_image(feed, :link, chars)
        {:ok, {"channel", scope, feed}}

      {:feed_image, "width"} ->
        width = parse_integer(chars)
        feed = update_feed_image(feed, :width, width)
        {:ok, {"channel", scope, feed}}

      {:feed_image, "height"} ->
        height = parse_integer(chars)
        feed = update_feed_image(feed, :height, height)
        {:ok, {"channel", scope, feed}}

      {:feed_image, "description"} ->
        feed = update_feed_image(feed, :description, chars)
        {:ok, {"channel", scope, feed}}

      #
      # Item elements
      #

      {:feed_item, "title"} ->
        feed = update_feed_item(feed, :title, chars)
        {:ok, {"channel", scope, feed}}

      {:feed_item, "link"} ->
        feed = update_feed_item(feed, :link, chars)
        {:ok, {"channel", scope, feed}}

      {:feed_item, "guid"} ->
        feed = update_feed_item(feed, :guid, chars)
        {:ok, {"channel", scope, feed}}

      {:feed_item, "pubDate"} ->
        date = parse_datetime(chars)
        feed = update_feed_item(feed, :pub_date, date)
        {:ok, {"channel", scope, feed}}

      {:feed_item, "description"} ->
        cdata = parse_cdata(chars)
        feed = update_feed_item(feed, :description, cdata)
        {:ok, {"channel", scope, feed}}

      _ ->
        {:ok, {current_tag, scope, feed}}
    end
  end

  # Updates the most recent feed item put into the list.
  defp update_feed_item(feed, key, value) do
    [current_item | items] = feed.items
    current_item = Map.put(current_item, key, value)
    %{feed | items: [current_item | items]}
  end

  # Updates the feed image struct
  defp update_feed_image(feed, key, value) do
    image = Map.put(feed.image, key, value)
    %{feed | image: image}
  end

  # Parses according to spec or returns the original value.
  defp parse_datetime(str) do
    case Timex.parse(str, "{RFC1123}") do
      {:ok, datetime} -> datetime
      {:error, value} -> value
    end
  end

  # Parses to integer or returns the original value
  defp parse_integer(str) do
    case Integer.parse(str) do
      {integer, _} -> integer
      :error -> str
    end
  end

  # Transforms all cdata into iodata.
  defp parse_cdata(str) do
    str
    |> Phoenix.HTML.html_escape()
    |> Phoenix.HTML.Safe.to_iodata()
  end

  def parse_cloud_attributes(list) do
    attrs = Map.new(list)

    %FeedCloud{
      domain: attrs["domain"],
      port: parse_integer(attrs["port"]),
      path: attrs["path"],
      register_procedure: attrs["registerProcedure"],
      protocol: attrs["protocol"]
    }
  end
end
