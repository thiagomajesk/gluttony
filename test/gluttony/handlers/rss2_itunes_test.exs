defmodule Gluttony.Handlers.RSS2ItunesTest do
  use ExUnit.Case

  @itunes_rss2 File.read!("test/fixtures/rss2_itunes.rss")

  setup_all do
    Gluttony.parse_string(@itunes_rss2)
  end

  describe "itunes rss 2.0 feed elements" do
    test "itunes_author", %{feed: feed} do
      assert feed.itunes_author == "The Sunset Explorers"
    end

    test "itunes_type", %{feed: feed} do
      assert feed.itunes_type == "serial"
    end

    test "itunes_owner", %{feed: feed} do
      assert %{
               name: "Sunset Explorers",
               email: "mountainscape@icloud.com"
             } = feed.itunes_owner
    end

    test "itunes_image", %{feed: feed} do
      assert feed.itunes_image ==
               "https://applehosted.podcasts.apple.com/hiking_treks/artwork.png"
    end

    test "itunes_categories", %{feed: feed} do
      assert feed.itunes_categories == ["Wilderness", "Sports"]
    end

    test "itunes_explicit", %{feed: feed} do
      assert feed.itunes_explicit == "false"
    end
  end

  describe "itunes rss 2.0 entry elements" do
    test "itunes_episode_type", %{entries: [entry | _]} do
      assert entry.itunes_episode_type == "trailer"
    end

    test "itunes_title", %{entries: [entry | _]} do
      assert entry.itunes_title == "Hiking Treks Trailer"
    end

    test "itunes_duration", %{entries: [entry | _]} do
      assert entry.itunes_duration == "1079"
    end

    test "itunes_explicit", %{entries: [entry | _]} do
      assert entry.itunes_explicit == "false"
    end
  end
end
