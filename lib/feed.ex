defmodule Gluttony.Feed do
  @moduledoc """
  Defines a feed channel.
  """

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
  @moduledoc """
  Defines a feed entry.
  """

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
