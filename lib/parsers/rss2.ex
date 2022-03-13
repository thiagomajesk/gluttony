defmodule Gluttony.Parsers.RSS2 do
  @behaviour Saxy.Handler

  defmodule Feed do
    defstruct [:title, :description, :link, :last_build_date, :managing_editor, items: []]
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

  def handle_event(:start_element, {name, _attributes}, {_current_tag, scope, feed}) do
    case name do
      "channel" ->
        feed = %Feed{}
        {:ok, {name, :feed, feed}}

      "item" ->
        items = [%FeedItem{} | feed.items]
        feed = %{feed | items: items}
        {:ok, {name, :item, feed}}

      _ ->
        {:ok, {name, scope, feed}}
    end
  end

  def handle_event(:end_element, _name, state) do
    {:ok, state}
  end

  def handle_event(:characters, chars, {current_tag, scope, feed}) do
    case {current_tag, scope} do
      {"title", :item} ->
        feed = update_feed_item(feed, :title, chars)
        {:ok, {"channel", scope, feed}}

      {"link", :item} ->
        feed = update_feed_item(feed, :link, chars)
        {:ok, {"channel", scope, feed}}

      {"guid", :item} ->
        feed = update_feed_item(feed, :guid, chars)
        {:ok, {"channel", scope, feed}}

      {"pubDate", :item} ->
        date = parse_datetime(chars)
        feed = update_feed_item(feed, :pub_date, date)
        {:ok, {"channel", scope, feed}}

      {"description", :item} ->
        cdata = parse_cdata(chars)
        feed = update_feed_item(feed, :description, cdata)
        {:ok, {"channel", scope, feed}}

      {"title", :feed} ->
        feed = %{feed | title: chars}
        {:ok, {"channel", scope, feed}}

      {"description", :feed} ->
        feed = %{feed | description: chars}
        {:ok, {"channel", scope, feed}}

      {"link", :feed} ->
        feed = %{feed | link: chars}
        {:ok, {"channel", scope, feed}}

      {"lastBuildDate", :feed} ->
        feed = %{feed | last_build_date: chars}
        {:ok, {"channel", scope, feed}}

      {"managingEditor", :feed} ->
        feed = %{feed | managing_editor: chars}
        {:ok, {"channel", scope, feed}}

      _ ->
        {:ok, {current_tag, scope, feed}}
    end
  end

  # Update the most recent feed item put into the list.
  defp update_feed_item(feed, key, value) do
    [current_item | items] = feed.items
    current_item = Map.put(current_item, key, value)
    %{feed | items: [current_item | items]}
  end

  # Parses according to spec or returns the original value.
  defp parse_datetime(str) do
    case Timex.parse(str, "{RFC1123}") do
      {:ok, datetime} -> datetime
      {:error, value} -> value
    end
  end

  # Transforms all cdata into iodata.
  defp parse_cdata(str) do
    str
    |> Phoenix.HTML.html_escape()
    |> Phoenix.HTML.Safe.to_iodata()
  end
end
