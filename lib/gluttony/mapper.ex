defmodule Gluttony.Mapper do
  @moduledoc false

  import Gluttony.Helpers
  alias Gluttony.{Feed, Entry}

  def map(feed, entries) do
    feed = map_feed(feed)
    entries = Enum.map(entries, &map_entry/1)
    Map.put(feed, :entries, entries)
  end

  defp map_feed(feed) do
    %Feed{
      id: feed[:guid] || feed[:id],
      title: feed[:title],
      url: feed[:link],
      description: feed[:description] || feed[:subtitle],
      links: feed[:links],
      updated: feed[:pub_date] || feed[:updated],
      authors: (feed[:author] && [feed[:author]]) || safe_concat(feed[:authors], feed[:contributors]),
      language: feed[:language],
      icon: feed[:icon],
      logo: feed[:image] || feed[:logo],
      copyright: feed[:copyright] || feed[:rights],
      categories: feed[:categories],
      __meta__: metadata(feed)
    }
  end

  defp map_entry(entry) do
    %Entry{
      id: entry[:guid] || entry[:id],
      title: entry[:title],
      url: entry[:link],
      description: entry[:description] || entry[:subtitle],
      links: entry[:links],
      updated: entry[:pub_date] || entry[:updated],
      published: entry[:published],
      authors: (entry[:author] && [entry[:author]]) || safe_concat(entry[:authors], entry[:contributors]),
      categories: entry[:categories],
      source: entry[:source],
      __meta__: metadata(entry)
    }
  end

  defp metadata(map) do
    Enum.reduce(map, %{}, fn {k, v}, metadata ->
      case {to_string(k), v} do
        {"googleplay_" <> key, v} -> place_in(metadata, [:googleplay, key], v)
        {"itunes_" <> key, v} -> place_in(metadata, [:itunes, key], v)
        _ -> metadata
      end
    end)
  end
end
