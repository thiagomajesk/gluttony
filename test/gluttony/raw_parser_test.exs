defmodule RawParserTest do
  use ExUnit.Case, async: true

  test "parses an RSS feed into a raw map" do
    xml = File.read!("test/fixtures/other/rss2_techcrunch_small.rss")

    assert {:ok, feed} = RawParser.parse(xml)

    assert %{
             "rss" => %{
               "channel" => %{
                 "title" => "TechCrunch",
                 "item" => [
                   %{
                     "title" => "You can now make GIFs in Twitter's iOS app",
                     "category" => ["Apps", "Twitter"]
                   },
                   %{"title" => "Startup funding slows down", "category" => "Startups"}
                 ]
               }
             }
           } = feed
  end
end
