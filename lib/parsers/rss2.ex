defmodule Gluttony.Parsers.RSS2 do
  @behaviour Saxy.Handler

  defmodule Feed do
    defstruct [:title, :description, :link, :last_build_date, :managing_editor, items: []]
  end

  defmodule FeedItem do
    defstruct [:title, :link, :guid, :pub_date, :description]
  end

  def handle_event(:start_document, [encoding: "utf-8", version: "1.0"], _state) do
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
        [current_item | items] = feed.items
        current_item = %{current_item | title: chars}
        items = [current_item | items]
        feed = %{feed | items: items}
        {:ok, {"channel", scope, feed}}

      {"link", :item} ->
        [current_item | items] = feed.items
        current_item = %{current_item | link: chars}
        items = [current_item | items]
        feed = %{feed | items: items}
        {:ok, {"channel", scope, feed}}

      {"guid", :item} ->
        [current_item | items] = feed.items
        current_item = %{current_item | guid: chars}
        items = [current_item | items]
        feed = %{feed | items: items}
        {:ok, {"channel", scope, feed}}

      {"pubDate", :item} ->
        [current_item | items] = feed.items
        date = Timex.parse!(chars, "{RFC1123}")
        current_item = %{current_item | pub_date: date}
        items = [current_item | items]
        feed = %{feed | items: items}
        {:ok, {"channel", scope, feed}}

      {"description", :item} ->
        [current_item | items] = feed.items
        current_item = %{current_item | description: chars}
        items = [current_item | items]
        feed = %{feed | items: items}
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

  def handle_event(:cdata, _cdata, state) do
    {:ok, state}
  end
end
