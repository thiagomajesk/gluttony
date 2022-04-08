defmodule GluttonyTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")

    xml1 = File.read!("test/fixtures/other/atom1_aws_blog.rss")
    xml2 = File.read!("test/fixtures/other/atom1_the_next_web.rss")
    xml3 = File.read!("test/fixtures/other/rss2_jovem_nerd.rss")
    xml4 = File.read!("test/fixtures/other/rss2_techcrunch.rss")

    {:ok, [xml1: xml1, xml2: xml2, xml3: xml3, xml4: xml4]}
  end

  describe "atom 1.0" do
    test "AWS News Blog", %{xml1: xml} do
      assert {:ok, %{feed: feed, entries: entries}} = Gluttony.parse_string(xml)
      assert feed.title == "AWS News Blog"
      assert Enum.count(entries) == 20
    end

    test "The Next Web", %{xml2: xml} do
      assert {:ok, %{feed: feed, entries: entries}} = Gluttony.parse_string(xml)
      assert feed.title == "The Next Web"
      assert Enum.count(entries) == 10
    end
  end

  describe "rss 2.0" do
    test "Jovem Nerd", %{xml3: xml} do
      assert {:ok, %{feed: feed, entries: entries}} = Gluttony.parse_string(xml)
      assert feed.title == "Jovem Nerd"
      assert Enum.count(entries) == 3000
    end

    test "TechCrunch", %{xml4: xml} do
      assert {:ok, %{feed: feed, entries: entries}} = Gluttony.parse_string(xml)
      assert feed.title == "TechCrunch"
      assert Enum.count(entries) == 20
    end
  end

  test "parse_string/2 returns proper error result" do
    assert {:error, "No handler available to parse this feed []"} = Gluttony.parse_string("<xml></xml>")
  end

  test "fetch_feed/2 properly fetches feed" do
    use_cassette "jovem_nerd_feed" do
      assert {:ok, %{feed: feed, entries: entries}} = Gluttony.fetch_feed("https://www.jovemnerd.com.br/feed/")
      assert feed.title == "Jovem Nerd"
      assert Enum.count(entries) == 3000
    end
  end
end
