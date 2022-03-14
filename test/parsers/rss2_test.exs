defmodule Gluttony.Parsers.RSS2Test do
  use ExUnit.Case
  doctest Gluttony.Parsers.RSS2

  # If CDATA is not getting pickedup, make sure this
  # this files were not processed or formatted: https://github.com/qcam/saxy/issues/98
  @standard_rss2 File.read!("test/fixtures/rss2/standard_rss2")

  setup_all do
    {:ok, feed} = Saxy.parse_string(@standard_rss2, Gluttony.Parsers.RSS2, nil)
    {:ok, feed: feed}
  end

  describe "required rss 2.0 elements" do
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
  end

  describe "optional rss 2.0 elements" do
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
      assert feed.pub_date == ~U[2002-09-07 00:00:01Z]
    end

    test "last_build_date", %{feed: feed} do
      assert feed.last_build_date == ~U[2002-09-07 09:42:31Z]
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
               port: 80,
               protocol: "soap",
               register_procedure: "pingMe"
             } = feed.cloud
    end

    test "ttl", %{feed: feed} do
      assert feed.ttl == 60
    end

    test "image", %{feed: feed} do
      assert %{
               description:
                 "Breaking news and stories from GoUpstate.com, a Spartanburg Herald-Journal Web site.",
               height: 35,
               link: "http://www.goupstate.com/",
               title: "GoUpstate.com News Headlines",
               url: "http://www.goupstate.com/images/goupstate_logo.gif",
               width: 140
             } = feed.image
    end
  end
end
