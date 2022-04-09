defmodule Gluttony.Mapper do
  @moduledoc false

  import Gluttony.Helpers

  alias Gluttony.{Feed, Entry}
  alias Gluttony.Accessor

  def map(feed, entries) do
    feed = map_feed(feed)
    entries = Enum.map(entries, &map_entry/1)
    Map.put(feed, :entries, entries)
  end

  defp map_feed(feed) do
    %Feed{
      id: Accessor.get(feed, [:guid, :id]),
      title: Accessor.get(feed, [:title]),
      url: Accessor.get(feed, [:link]),
      description: Accessor.get(feed, [:description, :subtitle]),
      links: Accessor.get(feed, [:links]),
      updated: Accessor.get(feed, [:pub_date, :updated]),
      authors: map_authors(feed),
      contributors: Accessor.get(feed, [:contributors]),
      language: Accessor.get(feed, [:language]),
      icon: Accessor.get(feed, [:icon]),
      logo: Accessor.get(feed, [:image, :logo]),
      copyright: Accessor.get(feed, [:copyright, :rights]),
      categories: Accessor.get(feed, [:categories]),
      __meta__: metadata(feed)
    }
  end

  defp map_entry(entry) do
    %Entry{
      id: Accessor.get(entry, [:guid, :id]),
      title: Accessor.get(entry, [:title]),
      url: Accessor.get(entry, [:link]),
      description: Accessor.get(entry, [:description, :subtitle]),
      links: Accessor.get(entry, [:links]),
      updated: Accessor.get(entry, [:pub_date, :updated]),
      published: Accessor.get(entry, [:published]),
      authors: map_authors(entry),
      contributors: Accessor.get(entry, [:contributors]),
      categories: Accessor.get(entry, [:categories]),
      source: Accessor.get(entry, [:source]),
      __meta__: metadata(entry)
    }
  end

  defp map_authors(map) do
    case Accessor.get(map, [:author, :authors]) do
      %Gluttony.Accessor.EmptyValue{} = not_found -> not_found
      value when not is_list(value) -> [value]
      value -> value
    end
  end

  defp metadata(map) do
    metadata =
      Enum.reduce(map, %{}, fn {k, v}, metadata ->
        case {to_string(k), v} do
          {"googleplay_" <> key, v} -> put_in(metadata, [:googleplay, key], v)
          {"itunes_" <> key, v} -> put_in(metadata, [:itunes, key], v)
          _ -> metadata
        end
      end)

    if metadata == %{}, do: nil, else: metadata
  end
end
