defmodule Gluttony.Unfurler do
  @moduledoc """
  Enriches feed data by unfurling available URLs.
  Uses `Gluttony.Fetchers.Favicon` and `Gluttony.Fetchers.Opengraph` internally.
  """

  alias Gluttony.{Feed, Entry}

  @doc """
  Accepts a `Gluttony.Feed` or `Gluttony.Entry` struct and retrieves data from the url.

  For `Feed`, it returns favicons and images available in the given URL.
  For `Entry`, it returns available opengraph information on the page.
  """
  def unfurl(term)

  def unfurl(%Feed{url: nil}), do: nil

  def unfurl(%Feed{url: url}) do
    case Gluttony.Fetchers.Favicon.get(url) do
      {:ok, response} -> response.body
      {:error, _reason} -> nil
    end
  end

  def unfurl(%Entry{url: nil}), do: nil

  def unfurl(%Entry{url: url}) do
    case Gluttony.Fetchers.Opengraph.get(url) do
      {:ok, response} -> response.body
      {:error, _reason} -> nil
    end
  end
end
