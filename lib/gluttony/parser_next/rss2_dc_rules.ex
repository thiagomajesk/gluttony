defmodule Gluttony.ParserNext.RSS2DCRules do
  @moduledoc false

  use Gluttony.ParserNext.Handler

  # Content

  content "rss/channel/item/dc:creator",
    target: [:feed, :items, Access.at(0), :author]
end
