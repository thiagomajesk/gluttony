defmodule Gluttony do
  @moduledoc """
  Documentation for `Gluttony`.
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
