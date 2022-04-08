defmodule Gluttony.Feed do
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
    :authors,
    :language,
    :icon,
    :logo,
    :copyright,
    categories: [],
    items: []
  ]
end
