defmodule Gluttony do
  @moduledoc """
  Parses RSS 2.0 and Atom 1.0 feeds.

  # References
  - RSS 2.0 Specs: https://www.rssboard.org/rss-specification
  - Atom 1.0 Specs: https://xml2rfc.tools.ietf.org/public/rfc/html/rfc4287.html
  - W3C Feed Docs: https://validator.w3.org/feed/docs/
  """

  def detect(xml) do
    if parseable?(xml) do
      cond do
        Regex.match?(~r|<rss version="2.0"|i, xml) -> :rss_2_0
        Regex.match?(~r|<feed xmlns="http://www.w3.org/2005/Atom"|i, xml) -> :atom_1_0
      end
    end
  end

  defp parseable?(xml) do
    Regex.match?(~r|<\?xml version="1.0" encoding="utf-8"\?>|i, xml)
  end
end
