defmodule Gluttony.ParserNext.RSS2ContentRules do
  @moduledoc false

  use Gluttony.ParserNext.Handler

  # Content

  content "rss/channel/item/content:encoded",
    target: [:feed, :items, Access.at(0), :content]
end
