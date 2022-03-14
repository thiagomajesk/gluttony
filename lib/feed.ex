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

defmodule Gluttony.FeedImage do
  defstruct [:url, :title, :link, :width, :height, :description]
end

defmodule Gluttony.FeedCloud do
  defstruct [:domain, :port, :path, :register_procedure, :protocol]
end

defmodule Gluttony.FeedItem do
  defstruct [:title, :link, :guid, :pub_date, :description]
end
