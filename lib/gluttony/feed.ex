defmodule Gluttony.Feed do
  @moduledoc """
  Defines a common channel interface for RSS 2.0 and Atom 1.0 feeds.
  """

  @type t :: %__MODULE__{}

  defstruct [
    :__meta__,
    :id,
    :title,
    :url,
    :description,
    :links,
    :updated,
    :authors,
    :contributors,
    :language,
    :icon,
    :logo,
    :copyright,
    categories: [],
    entries: []
  ]
end
