defmodule Gluttony.Feed do
  defstruct [
    :title,
    :link,
    :description,
    :language,
    :copyright,
    :managing_editor,
    :web_master,
    :pub_date,
    :last_build_date,
    :generator,
    :docs,
    :cloud,
    :ttl,
    :image,
    :rating,
    :text_input,
    :skip_hours,
    :skip_days,
    categories: [],
    items: []
  ]
end

defmodule Gluttony.FeedItem do
  defstruct [:title, :link, :guid, :pub_date, :description]
end
