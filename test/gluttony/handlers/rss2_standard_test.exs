defmodule Gluttony.Handlers.RSS2StandardTest do
  use ExUnit.Case

  @standard_rss2 File.read!("test/fixtures/rss2_standard.rss")

  setup_all do
    Gluttony.parse_string(@standard_rss2)
  end

  describe "rss 2.0 feed elements" do
    test "title", %{feed: feed} do
      assert feed.title == "GoUpstate.com News Headlines"
    end

    test "link", %{feed: feed} do
      assert feed.link == "http://www.goupstate.com/"
    end

    test "description", %{feed: feed} do
      assert feed.description ==
               "The latest news from GoUpstate.com, a Spartanburg Herald-Journal Web site."
    end

    test "language", %{feed: feed} do
      assert feed.language == "en-us"
    end

    test "copyright", %{feed: feed} do
      assert feed.copyright == "Copyright 2002, Spartanburg Herald-Journal"
    end

    test "managing_editor", %{feed: feed} do
      assert feed.managing_editor == "geo@herald.com (George Matesky)"
    end

    test "web_master", %{feed: feed} do
      assert feed.web_master == "betty@herald.com (Betty Guernsey)"
    end

    test "pub_date", %{feed: feed} do
      assert feed.pub_date == "Sat, 07 Sep 2002 00:00:01 GMT"
    end

    test "last_build_date", %{feed: feed} do
      assert feed.last_build_date == "Sat, 07 Sep 2002 09:42:31 GMT"
    end

    test "categories", %{feed: feed} do
      assert feed.categories == ["General", "Newspapers"]
    end

    test "generator", %{feed: feed} do
      assert feed.generator == "MightyInHouse Content System v2.3"
    end

    test "docs", %{feed: feed} do
      assert feed.docs == "https://www.rssboard.org/rss-specification"
    end

    test "cloud", %{feed: feed} do
      assert %{
               domain: "rpc.sys.com",
               path: "/RPC2",
               port: "80",
               protocol: "soap",
               register_procedure: "pingMe"
             } = feed.cloud
    end

    test "ttl", %{feed: feed} do
      assert feed.ttl == "60"
    end

    test "image", %{feed: feed} do
      assert %{
               description:
                 "Breaking news and stories from GoUpstate.com, a Spartanburg Herald-Journal Web site.",
               height: "35",
               link: "http://www.goupstate.com/",
               title: "GoUpstate.com News Headlines",
               url: "http://www.goupstate.com/images/goupstate_logo.gif",
               width: "140"
             } = feed.image
    end

    test "rating", %{feed: feed} do
      assert feed.rating ==
               ~s|(PICS-1.1 "http://www.gcf.org/v2.5" labels on "1994.11.05T08:15-0500" until "1995.12.31T23:59-0000" for "http://w3.org/PICS/Overview.html" ratings (suds 0.5 density 0 color/hue 1))|
    end

    test "text_input", %{feed: feed} do
      assert %{
               description: "Search GoUpstate.com",
               name: "s",
               title: "Search",
               link: "https://www.goupstate.com/search.php"
             } = feed.text_input
    end

    test "skip_hours", %{feed: feed} do
      assert feed.skip_hours == ["24", "12"]
    end

    test "skip_days", %{feed: feed} do
      assert feed.skip_days == ["Friday", "Monday"]
    end
  end

  describe "rss 2.0 entry elements" do
    test "title", %{entries: [entry | _]} do
      assert entry.title == "Atom-Powered Robots Run Amok"
    end

    test "link", %{entries: [entry | _]} do
      assert entry.link == "http://example.org/2003/12/13/atom03"
    end

    test "description", %{entries: [entry | _]} do
      assert entry.description == "Some text."
    end

    test "author", %{entries: [entry | _]} do
      assert entry.author == "lawyer@boyer.net (Lawyer Boyer)"
    end

    test "categories", %{entries: [entry | _]} do
      assert entry.categories == ["MSFT", "Grateful Dead"]
    end

    test "comments", %{entries: [entry | _]} do
      assert entry.comments == "http://ekzemplo.com/entry/4403/comments"
    end

    test "enclosure", %{entries: [entry | _]} do
      assert %{
               url: "http://www.scripting.com/mp3s/weatherReportSuite.mp3",
               length: "12216320",
               type: "audio/mpeg"
             } = entry.enclosure
    end

    test "guid", %{entries: [entry | _]} do
      assert entry.guid == "http://inessential.com/2002/09/01.php#a2"
    end

    test "pub_date", %{entries: [entry | _]} do
      assert entry.pub_date == "Sun, 19 May 2002 15:21:36 GMT"
    end

    test "source", %{entries: [entry | _]} do
      assert entry.source == "Tomalak's Realm"
    end
  end
end
