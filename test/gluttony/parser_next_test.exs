defmodule Gluttony.ParserNextTest do
  use ExUnit.Case, async: true

  @rss2 File.read!("test/fixtures/rss2_standard.rss")
  @itunes_rss2 File.read!("test/fixtures/rss2_itunes.rss")
  @googleplay_rss2 File.read!("test/fixtures/rss2_googleplay.rss")
  @new_jersey_monitor_rss2 "fixture/vcr_cassettes/new_jersey_monitor_feed.json"
                           |> File.read!()
                           |> Jason.decode!()
                           |> hd()
                           |> get_in(["response", "body"])

  test "parses RSS2 content extension fields through source target rules" do
    assert {:ok, %{feed: %{items: entries}}} =
             Gluttony.ParserNext.parse(@new_jersey_monitor_rss2)

    assert length(entries) > 1

    entry = find_entry_by_title(entries, "Gov. Sherrill implements protest zones")

    assert entry.content =~ ~s(<figure><img width="1024" height="683")
    assert entry.content =~ "1Y6A3564-1024x683.jpg"
    assert entry.content =~ "Gov. Mikie Sherrill announced Friday"
  end

  test "parses RSS2 dc extension fields through source target rules" do
    assert {:ok, %{feed: %{items: entries}}} =
             Gluttony.ParserNext.parse(@new_jersey_monitor_rss2)

    assert length(entries) > 1

    entry = find_entry_by_title(entries, "Gov. Sherrill implements protest zones")

    assert entry.author == "Sophie Nieto-Munoz"
  end

  test "parses RSS2 googleplay extension fields through source target rules" do
    assert {:ok, %{feed: %{items: [entry | _entries]} = feed}} =
             Gluttony.ParserNext.parse(@googleplay_rss2)

    assert feed.googleplay_author == "Unannounced Podcaster"

    assert feed.googleplay_description ==
             "The Unknown Podcast will look at all the things that are unknown or unknowable. Find us on Google Play Music!"

    assert feed.googleplay_email == "unknown-podcast@sample.com"
    assert feed.googleplay_image == "http://sample.com/podcasts/unknown/UnknownLargeImage.jpg"
    assert feed.googleplay_categories == ["Technology"]

    assert entry.googleplay_author == "Engima"
    assert entry.googleplay_description == "We look at all the things that are out there that we'd like to know."
    assert entry.googleplay_image == "http://sample.com/podcasts/unknown/Episode1.jpg"
  end

  test "parses RSS2 itunes extension fields through source target rules" do
    assert {:ok, %{feed: %{items: [entry | _entries]} = feed}} =
             Gluttony.ParserNext.parse(@itunes_rss2)

    assert feed.itunes_author == "The Sunset Explorers"
    assert feed.itunes_type == "serial"

    assert %{
             name: "Sunset Explorers",
             email: "mountainscape@icloud.com"
           } = feed.itunes_owner

    assert feed.itunes_image ==
             "https://applehosted.podcasts.apple.com/hiking_treks/artwork.png"

    assert feed.itunes_categories == ["Wilderness", "Sports"]
    assert feed.itunes_explicit == "false"

    assert entry.itunes_episode_type == "trailer"
    assert entry.itunes_title == "Hiking Treks Trailer"
    assert entry.itunes_duration == "1079"
    assert entry.itunes_explicit == "false"
  end

  test "parses repeated RSS2 items as separate nested maps" do
    xml = """
    <?xml version="1.0" encoding="utf-8"?>
    <rss version="2.0">
      <channel>
        <title>Container Test</title>
        <item>
          <title>First item</title>
          <category>One</category>
          <enclosure url="https://example.com/first.mp3" length="123" type="audio/mpeg" />
        </item>
        <item>
          <title>Second item</title>
          <category>Two</category>
          <enclosure url="https://example.com/second.mp3" length="456" type="audio/mpeg" />
        </item>
      </channel>
    </rss>
    """

    assert {:ok, %{feed: %{items: entries}}} = Gluttony.ParserNext.parse(xml)
    assert length(entries) == 2

    first_entry = find_entry_by_title(entries, "First item")
    second_entry = find_entry_by_title(entries, "Second item")

    assert first_entry.categories == ["One"]
    assert first_entry.enclosure.url == "https://example.com/first.mp3"

    assert second_entry.categories == ["Two"]
    assert second_entry.enclosure.url == "https://example.com/second.mp3"
  end

  test "parses split content chunks as text" do
    xml = """
    <?xml version="1.0" encoding="utf-8"?>
    <rss version="2.0">
      <channel>
        <title>Hello<![CDATA[Wide]]>World</title>
      </channel>
    </rss>
    """

    assert {:ok, %{feed: feed}} = Gluttony.ParserNext.parse(xml)
    assert feed.title == "HelloWideWorld"
  end

  test "parses RSS2 standard fields through source target rules" do
    assert {:ok, %{feed: %{items: [entry]} = feed}} = Gluttony.ParserNext.parse(@rss2)

    assert feed.title == "GoUpstate.com News Headlines"
    assert feed.link == "http://www.goupstate.com/"

    assert feed.description ==
             "The latest news from GoUpstate.com, a Spartanburg Herald-Journal Web site."

    assert feed.language == "en-us"
    assert feed.copyright == "Copyright 2002, Spartanburg Herald-Journal"
    assert feed.managing_editor == "geo@herald.com (George Matesky)"
    assert feed.web_master == "betty@herald.com (Betty Guernsey)"
    assert feed.pub_date == "Sat, 07 Sep 2002 00:00:01 GMT"
    assert feed.last_build_date == "Sat, 07 Sep 2002 09:42:31 GMT"
    assert feed.categories == ["General", "Newspapers"]
    assert feed.generator == "MightyInHouse Content System v2.3"
    assert feed.docs == "https://www.rssboard.org/rss-specification"
    assert feed.ttl == "60"

    assert feed.rating ==
             ~s|(PICS-1.1 "http://www.gcf.org/v2.5" labels on "1994.11.05T08:15-0500" until "1995.12.31T23:59-0000" for "http://w3.org/PICS/Overview.html" ratings (suds 0.5 density 0 color/hue 1))|

    assert feed.skip_hours == ["24", "12"]
    assert feed.skip_days == ["Friday", "Monday"]

    assert %{
             description: "Breaking news and stories from GoUpstate.com, a Spartanburg Herald-Journal Web site.",
             height: "35",
             link: "http://www.goupstate.com/",
             title: "GoUpstate.com News Headlines",
             url: "http://www.goupstate.com/images/goupstate_logo.gif",
             width: "140"
           } = feed.image

    assert %{
             description: "Search GoUpstate.com",
             link: "https://www.goupstate.com/search.php",
             name: "s",
             title: "Search"
           } = feed.text_input

    assert %{
             domain: "rpc.sys.com",
             path: "/RPC2",
             port: "80",
             protocol: "soap",
             register_procedure: "pingMe"
           } = feed.cloud

    assert entry.title == "Atom-Powered Robots Run Amok"
    assert entry.link == "http://example.org/2003/12/13/atom03"
    assert entry.description == "Some text."
    assert entry.author == "lawyer@boyer.net (Lawyer Boyer)"
    assert entry.categories == ["MSFT", "Grateful Dead"]
    assert entry.comments == "http://ekzemplo.com/entry/4403/comments"
    assert entry.guid == "http://inessential.com/2002/09/01.php#a2"
    assert entry.pub_date == "Sun, 19 May 2002 15:21:36 GMT"
    assert entry.source == "Tomalak's Realm"

    assert %{
             length: "12216320",
             type: "audio/mpeg",
             url: "http://www.scripting.com/mp3s/weatherReportSuite.mp3"
           } = entry.enclosure
  end

  defp find_entry_by_title(entries, title) do
    Enum.find(entries, &String.starts_with?(&1.title, title))
  end
end
