defmodule Gluttony.Feed do
  @moduledoc false

  @type t :: __MODULE__

  defstruct [
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

defmodule Gluttony.FeedItem do
  @moduledoc false

  @type t :: __MODULE__

  defstruct [
    :id,
    :title,
    :url,
    :description,
    :links,
    :updated,
    :published,
    :authors,
    :categories,
    :source
  ]
end
