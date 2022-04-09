defmodule Gluttony.Entry do
  @moduledoc false

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
