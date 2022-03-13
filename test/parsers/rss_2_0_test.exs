defmodule Gluttony.Parsers.RSS_2_0Test do
  use ExUnit.Case
  doctest Gluttony.Parsers.RSS_2_0

  @rss_2_0 File.read!("test/fixtures/rss_2_0")

  setup do
    {:ok, feed} = Saxy.parse_string(@rss_2_0, Gluttony.Parsers.RSS_2_0, nil)
    {:ok, feed: feed}
  end

  describe "parsed basic rss 2.0" do
    test "contains title", %{feed: feed} do
      assert feed.title == "Example Feed"
    end

    test "contains description", %{feed: feed} do
      assert feed.description == "Insert witty or insightful remark here"
    end

    test "contains link", %{feed: feed} do
      assert feed.link == "http://example.org/"
    end

    test "contains last_build_date", %{feed: feed} do
      assert feed.last_build_date == "Sat, 13 Dec 2003 18:30:02 GMT"
    end

    test "contains managing_editor", %{feed: feed} do
      assert feed.managing_editor == "johndoe@example.com (John Doe)"
    end
  end
end
