defmodule Gluttony.ParserNext.RSS2ItunesRules do
  @moduledoc false

  use Gluttony.ParserNext.Handler

  # Attributes

  attribute "rss/channel/itunes:image/href",
    target: [:feed, :itunes_image]

  attribute "rss/channel/itunes:category/text",
    type: {:array, :string},
    target: [:feed, Access.key(:itunes_categories, [])]

  attribute "rss/channel/itunes:category/itunes:category/text",
    type: {:array, :string},
    target: [:feed, Access.key(:itunes_categories, [])]

  # Content

  content "rss/channel/itunes:author",
    target: [:feed, :itunes_author]

  content "rss/channel/itunes:type",
    target: [:feed, :itunes_type]

  content "rss/channel/itunes:owner/itunes:name",
    target: [:feed, :itunes_owner, :name]

  content "rss/channel/itunes:owner/itunes:email",
    target: [:feed, :itunes_owner, :email]

  content "rss/channel/itunes:explicit",
    target: [:feed, :itunes_explicit]

  content "rss/channel/item/itunes:episodeType",
    target: [:feed, :items, Access.at(0), :itunes_episode_type]

  content "rss/channel/item/itunes:title",
    target: [:feed, :items, Access.at(0), :itunes_title]

  content "rss/channel/item/itunes:duration",
    target: [:feed, :items, Access.at(0), :itunes_duration]

  content "rss/channel/item/itunes:explicit",
    target: [:feed, :items, Access.at(0), :itunes_explicit]
end
