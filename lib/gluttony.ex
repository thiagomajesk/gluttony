defmodule Gluttony do
  @moduledoc """
  Parses RSS 2.0 and Atom 1.0 feeds.

  # References
  - RSS 2.0 Specs: https://www.rssboard.org/rss-specification
  - Atom 1.0 Specs: https://xml2rfc.tools.ietf.org/public/rfc/html/rfc4287.html

  ## Extra information

  - W3C Feed Docs: https://validator.w3.org/feed/docs/
  - RSS 2.0 and Atom 1.0 compared: http://www.intertwingly.net/wiki/pie/Rss20AndAtom10Compared
  """

  @doc """
  Parses the given string and returns the values.

  # Examples

    Parsing a xml string from a RSS feed:

      {:ok, %{feed: feed, entries: entries}} = Gluttony.parse_string(xml)

    When a error happens, the reason is returned:

      {:error, reason} = Gluttony.parse_string(xml)

    You can retrieve a common result interface by specifying the `raw` option as `false`.
    This might be useful to retrieve only relevant and common information, since RSS 2.0 and Atom 1.0 are very different specs:

      {:ok, %Gluttony.Feed{}} = Gluttony.parse_string(xml, raw: false)
  """
  def parse_string(xml, opts \\ []), do: parse(xml, opts)

  @doc """
  Fetches the given url and parses the response.
  See `parse_string/2` for more information on the result values.
  """
  def fetch_feed(url, opts \\ []) do
    with {:ok, response} <- HTTPoison.get(url),
         {:ok, result} <- parse(response.body, opts) do
      {:ok, result}
    end
  end

  @doc """
  Parses a stream of input and returns the values.

  # Examples

    Parsing an XML stream from an RSS feed:

      stream = File.stream!("rss_feed.xml", :line, [encoding: :utf8])
      {:ok, %{feed: feed, entries: entries}} = Gluttony.parse_stream(stream)
  """
  def parse_stream(stream, opts \\ []) do
    case Saxy.parse_stream(stream, Gluttony.Parser, opts) do
      {:ok, result} -> {:ok, result}
      {:halt, reason, _buffer} -> {:error, reason}
      {:error, reason} -> {:error, reason}
    end
  end

  defp parse(xml, opts) do
    case Saxy.parse_string(xml, Gluttony.Parser, opts) do
      {:ok, result} -> {:ok, result}
      {:halt, reason, _buffer} -> {:error, reason}
      {:error, reason} -> {:error, reason}
    end
  end
end
