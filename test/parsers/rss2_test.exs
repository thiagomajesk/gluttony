defmodule Gluttony.Parsers.RSS2Test do
  use ExUnit.Case
  doctest Gluttony.Parsers.RSS2

  # If CDATA is not getting pickedup, make sure this
  # this files were not processed or formatted: https://github.com/qcam/saxy/issues/98
  @basic_rss2 File.read!("test/fixtures/basic_rss2")
  @complex_rss2 File.read!("test/fixtures/techcrunch_rss2")

  describe "parsed basic rss 2.0" do
    setup do
      {:ok, feed} = Saxy.parse_string(@basic_rss2, Gluttony.Parsers.RSS2, nil)
      {:ok, feed: feed}
    end

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
      assert feed.last_build_date == ~U[2003-12-13 18:30:02Z]
    end

    test "contains managing_editor", %{feed: feed} do
      assert feed.managing_editor == "johndoe@example.com (John Doe)"
    end
  end

  describe "complex rss 2.0" do
    setup do
      {:ok, feed} = Saxy.parse_string(@complex_rss2, Gluttony.Parsers.RSS2, nil)
      {:ok, feed: feed}
    end

    test "item contains cdata description", %{feed: feed} do
      guid = "https://techcrunch.com/?p=2275698"
      item = Enum.find(feed.items, &(&1.guid == guid))
      assert item.description != nil
    end

    test "parses feed image", %{feed: feed} do
      assert %{
               url:
                 "https://techcrunch.com/wp-content/uploads/2015/02/cropped-cropped-favicon-gradient.png?w=32",
               title: "TechCrunch",
               link: "https://techcrunch.com",
               width: 32,
               height: 32
             } = feed.image
    end
  end
end
