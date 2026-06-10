defmodule Gluttony.ParserNext.RSS2Rules do
  @moduledoc false

  use Gluttony.ParserNext.Handler

  # Elements

  element "rss/channel/item",
    target: [:feed, Access.key(:items, [])]

  # Attributes

  attribute "rss/channel/cloud/domain",
    target: [:feed, :cloud, :domain]

  attribute "rss/channel/cloud/port",
    target: [:feed, :cloud, :port]

  attribute "rss/channel/cloud/path",
    target: [:feed, :cloud, :path]

  attribute "rss/channel/cloud/registerProcedure",
    target: [:feed, :cloud, :register_procedure]

  attribute "rss/channel/cloud/protocol",
    target: [:feed, :cloud, :protocol]

  attribute "rss/channel/item/enclosure/url",
    target: [:feed, :items, Access.at(0), :enclosure, :url]

  attribute "rss/channel/item/enclosure/length",
    target: [:feed, :items, Access.at(0), :enclosure, :length]

  attribute "rss/channel/item/enclosure/type",
    target: [:feed, :items, Access.at(0), :enclosure, :type]

  # Content

  content "rss/channel/skipHours/hour",
    type: {:array, :string},
    target: [:feed, Access.key(:skip_hours, [])]

  content "rss/channel/skipDays/day",
    type: {:array, :string},
    target: [:feed, Access.key(:skip_days, [])]

  content "rss/channel/title",
    target: [:feed, :title]

  content "rss/channel/link",
    target: [:feed, :link]

  content "rss/channel/description",
    target: [:feed, :description]

  content "rss/channel/language",
    target: [:feed, :language]

  content "rss/channel/copyright",
    target: [:feed, :copyright]

  content "rss/channel/managingEditor",
    target: [:feed, :managing_editor]

  content "rss/channel/webMaster",
    target: [:feed, :web_master]

  content "rss/channel/pubDate",
    target: [:feed, :pub_date]

  content "rss/channel/lastBuildDate",
    target: [:feed, :last_build_date]

  content "rss/channel/category",
    type: {:array, :string},
    target: [:feed, Access.key(:categories, [])]

  content "rss/channel/generator",
    target: [:feed, :generator]

  content "rss/channel/docs",
    target: [:feed, :docs]

  content "rss/channel/ttl",
    target: [:feed, :ttl]

  content "rss/channel/rating",
    target: [:feed, :rating]

  content "rss/channel/image/url",
    target: [:feed, :image, :url]

  content "rss/channel/image/title",
    target: [:feed, :image, :title]

  content "rss/channel/image/link",
    target: [:feed, :image, :link]

  content "rss/channel/image/width",
    target: [:feed, :image, :width]

  content "rss/channel/image/height",
    target: [:feed, :image, :height]

  content "rss/channel/image/description",
    target: [:feed, :image, :description]

  content "rss/channel/textInput/title",
    target: [:feed, :text_input, :title]

  content "rss/channel/textInput/description",
    target: [:feed, :text_input, :description]

  content "rss/channel/textInput/name",
    target: [:feed, :text_input, :name]

  content "rss/channel/textInput/link",
    target: [:feed, :text_input, :link]

  content "rss/channel/item/title",
    target: [:feed, :items, Access.at(0), :title]

  content "rss/channel/item/link",
    target: [:feed, :items, Access.at(0), :link]

  content "rss/channel/item/guid",
    target: [:feed, :items, Access.at(0), :guid]

  content "rss/channel/item/pubDate",
    target: [:feed, :items, Access.at(0), :pub_date]

  content "rss/channel/item/description",
    target: [:feed, :items, Access.at(0), :description]

  content "rss/channel/item/author",
    target: [:feed, :items, Access.at(0), :author]

  content "rss/channel/item/category",
    type: {:array, :string},
    target: [:feed, :items, Access.at(0), Access.key(:categories, [])]

  content "rss/channel/item/comments",
    target: [:feed, :items, Access.at(0), :comments]

  content "rss/channel/item/source",
    target: [:feed, :items, Access.at(0), :source]
end
