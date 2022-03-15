defmodule Gluttony.Handlers.RSS2StandardTest do
  use ExUnit.Case

  # If CDATA is not getting pickedup, make sure this
  # this files were not processed or formatted: https://github.com/qcam/saxy/issues/98
  @standard_rss2 File.read!("test/fixtures/rss2_standard")

  setup_all do
    Gluttony.Parser.parse_string(@standard_rss2)
  end

  describe "required rss 2.0 channel elements" do
    test "title", %{channel: channel} do
      assert channel.title == "GoUpstate.com News Headlines"
    end

    test "link", %{channel: channel} do
      assert channel.link == "http://www.goupstate.com/"
    end

    test "description", %{channel: channel} do
      assert channel.description ==
               "The latest news from GoUpstate.com, a Spartanburg Herald-Journal Web site."
    end
  end

  describe "optional rss 2.0 channel elements" do
    test "language", %{channel: channel} do
      assert channel.language == "en-us"
    end

    test "copyright", %{channel: channel} do
      assert channel.copyright == "Copyright 2002, Spartanburg Herald-Journal"
    end

    test "managing_editor", %{channel: channel} do
      assert channel.managing_editor == "geo@herald.com (George Matesky)"
    end

    test "web_master", %{channel: channel} do
      assert channel.web_master == "betty@herald.com (Betty Guernsey)"
    end

    test "pub_date", %{channel: channel} do
      assert channel.pub_date == ~U[2002-09-07 00:00:01Z]
    end

    test "last_build_date", %{channel: channel} do
      assert channel.last_build_date == ~U[2002-09-07 09:42:31Z]
    end

    test "categories", %{channel: channel} do
      assert channel.categories == ["General", "Newspapers"]
    end

    test "generator", %{channel: channel} do
      assert channel.generator == "MightyInHouse Content System v2.3"
    end

    test "docs", %{channel: channel} do
      assert channel.docs == "https://www.rssboard.org/rss-specification"
    end

    test "cloud", %{channel: channel} do
      assert %{
               domain: "rpc.sys.com",
               path: "/RPC2",
               port: 80,
               protocol: "soap",
               register_procedure: "pingMe"
             } = channel.cloud
    end

    test "ttl", %{channel: channel} do
      assert channel.ttl == 60
    end

    test "image", %{channel: channel} do
      assert %{
               description:
                 "Breaking news and stories from GoUpstate.com, a Spartanburg Herald-Journal Web site.",
               height: 35,
               link: "http://www.goupstate.com/",
               title: "GoUpstate.com News Headlines",
               url: "http://www.goupstate.com/images/goupstate_logo.gif",
               width: 140
             } = channel.image
    end

    test "rating", %{channel: channel} do
      assert channel.rating ==
               ~s|(PICS-1.1 "http://www.gcf.org/v2.5" labels on "1994.11.05T08:15-0500" until "1995.12.31T23:59-0000" for "http://w3.org/PICS/Overview.html" ratings (suds 0.5 density 0 color/hue 1))|
    end

    test "text_input", %{channel: channel} do
      assert %{
               description: "Search GoUpstate.com",
               name: "s",
               title: "Search",
               link: "https://www.goupstate.com/search.php"
             } = channel.text_input
    end

    test "skip_hours", %{channel: channel} do
      assert channel.skip_hours == [24, 12]
    end

    test "skip_days", %{channel: channel} do
      assert channel.skip_days == [:friday, :monday]
    end
  end

  describe "rss 2.0 item elements" do
    test "title", %{items: [item | _]} do
      assert item.title == "Atom-Powered Robots Run Amok"
    end

    test "link", %{items: [item | _]} do
      assert item.link == "http://example.org/2003/12/13/atom03"
    end

    test "description", %{items: [item | _]} do
      assert item.description == "Some text."
    end

    test "author", %{items: [item | _]} do
      assert item.author == "lawyer@boyer.net (Lawyer Boyer)"
    end

    test "categories", %{items: [item | _]} do
      assert item.categories == ["MSFT", "Grateful Dead"]
    end

    test "comments", %{items: [item | _]} do
      assert item.comments == "http://ekzemplo.com/entry/4403/comments"
    end

    test "enclosure", %{items: [item | _]} do
      assert %{
               url: "http://www.scripting.com/mp3s/weatherReportSuite.mp3",
               length: 12_216_320,
               type: "audio/mpeg"
             } = item.enclosure
    end

    test "guid", %{items: [item | _]} do
      assert item.guid == "http://inessential.com/2002/09/01.php#a2"
    end

    test "pub_date", %{items: [item | _]} do
      assert item.pub_date == ~U[2002-05-19 15:21:36Z]
    end

    test "source", %{items: [item | _]} do
      assert item.source == "Tomalak's Realm"
    end
  end
end
