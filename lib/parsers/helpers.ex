defmodule Gluttony.Parsers.Helpers do
  # Updates the most recent feed item put into the list.
  def update_feed_item(feed, key, value) do
    [current_item | items] = feed.items
    current_item = Map.put(current_item, key, value)
    %{feed | items: [current_item | items]}
  end

  # Updates the feed image struct
  def update_feed_image(feed, key, value) do
    image = Map.put(feed.image, key, value)
    %{feed | image: image}
  end

  # Parses according to spec or returns the original value.
  def parse_datetime(str) do
    case Timex.parse(str, "{RFC1123}") do
      {:ok, datetime} -> datetime
      {:error, value} -> value
    end
  end

  # Parses to integer or returns the original value
  def parse_integer(str) do
    case Integer.parse(str) do
      {integer, _} -> integer
      :error -> str
    end
  end

  # Transforms all cdata into iodata.
  def parse_cdata(str) do
    str
    |> Phoenix.HTML.html_escape()
    |> Phoenix.HTML.Safe.to_iodata()
  end

  def parse_cloud_attributes(list) do
    attrs = Map.new(list)

    %{
      domain: attrs["domain"],
      port: parse_integer(attrs["port"]),
      path: attrs["path"],
      register_procedure: attrs["registerProcedure"],
      protocol: attrs["protocol"]
    }
  end
end
