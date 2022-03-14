defmodule Gluttony.Handlers.RSS2StandardTest do
  use ExUnit.Case

  # If CDATA is not getting pickedup, make sure this
  # this files were not processed or formatted: https://github.com/qcam/saxy/issues/98
  @standard_rss2 File.read!("test/fixtures/rss2_standard")

  setup_all do
    Gluttony.Parser.parse_string(@standard_rss2)
  end

  describe "required rss 2.0 elements" do
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

  describe "optional rss 2.0 elements" do
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
  end
end
