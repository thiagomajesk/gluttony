defmodule Gluttony.Parsers.RSS2Test do
  use ExUnit.Case
  doctest Gluttony.Parsers.RSS2

  # If CDATA is not getting pickedup, make sure this
  # this files were not processed or formatted: https://github.com/qcam/saxy/issues/98
  @basic_rss2 File.read!("test/fixtures/basic_rss2")
  @complex_rss2 File.read!("test/fixtures/jovem_nerd_rss2")

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
      assert feed.last_build_date == "Sat, 13 Dec 2003 18:30:02 GMT"
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

    test "contains title", %{feed: feed} do
      assert feed.title == "Jovem Nerd"
    end

    test "item contains cdata description", %{feed: feed} do
      guid = "https://jovemnerd.com.br/?post_type=news&p=488137"
      item = Enum.find(feed.items, &(&1.guid == guid))
      assert item.description != nil
    end
  end
end
