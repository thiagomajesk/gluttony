defmodule Gluttony.Unfurler do
  @moduledoc """
  Enriches feed data by unfurling available urls.

  For feeds, it returns favicons and images available in the URL.
  FOr entries, it returns the available opengraph information on the page.
  """

  alias Gluttony.{Feed, Entry}

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
