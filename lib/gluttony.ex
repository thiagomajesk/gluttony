defmodule Gluttony do
  @moduledoc """
  Parses RSS 2.0 and Atom 1.0 feeds.

  # References
  - RSS 2.0 Specs: https://www.rssboard.org/rss-specification
  - Atom 1.0 Specs: https://xml2rfc.tools.ietf.org/public/rfc/html/rfc4287.html

  # Extra information

  - W3C Feed Docs: https://validator.w3.org/feed/docs/
  - RSS 2.0 and Atom 1.0 compared: http://www.intertwingly.net/wiki/pie/Rss20AndAtom10Compared
  """

  @doc """
  Parses the given string and returns the values.

  # Examples

    Parsing a xml string from a RSS feed:

      {:ok, %{feed: feed, entries: entries}} = Gluttone.parse_string(xml)

    Returning a formatted struct instead of the raw values. See `Gluttony.Handler.to_feed/1`:

      {:ok, %{feed: %Gluttony.Feed{}}} = Gluttone.parse_string(xml, raw: false)

    When a error happens, the reason is returned:

      {:halt, reason} = Gluttone.parse_string(xml)

  # Options
    - `raw`: If false, returns the a formatted `%Gluttony.Feed{}` struct. Defaults to true.
  """
  def parse_string(xml, opts \\ []) do
    Saxy.parse_string(xml, Gluttony.Parser, opts)
  end
end
