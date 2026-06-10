defmodule Gluttony.ParserNext.RSS2GoogleplayRules do
  @moduledoc false

  use Gluttony.ParserNext.Handler

  # Attributes

  attribute "rss/channel/googleplay:image/href",
    target: [:feed, :googleplay_image]

  attribute "rss/channel/googleplay:category/text",
    type: {:array, :string},
    target: [:feed, Access.key(:googleplay_categories, [])]

  attribute "rss/channel/item/googleplay:image/href",
    target: [:feed, :items, Access.at(0), :googleplay_image]

  # Content

  content "rss/channel/googleplay:author",
    target: [:feed, :googleplay_author]

  content "rss/channel/googleplay:description",
    target: [:feed, :googleplay_description]

  content "rss/channel/googleplay:email",
    target: [:feed, :googleplay_email]

  content "rss/channel/item/googleplay:author",
    target: [:feed, :items, Access.at(0), :googleplay_author]

  content "rss/channel/item/googleplay:description",
    target: [:feed, :items, Access.at(0), :googleplay_description]
end
