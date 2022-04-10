defmodule Gluttony.Entry do
  @moduledoc """
  Defines a common entry interface for RSS 2.0 and Atom 1.0 feeds.
  """

  @type t :: __MODULE__

  defstruct [
    :__meta__,
    :id,
    :title,
    :url,
    :description,
    :links,
    :updated,
    :published,
    :authors,
    :contributors,
    :categories,
    :source
  ]
end
