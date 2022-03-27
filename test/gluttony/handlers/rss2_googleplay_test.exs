defmodule Gluttony.Handlers.RSS2GoogleplayTest do
  use ExUnit.Case

  @googleplay_rss2 File.read!("test/fixtures/rss2_googleplay.rss")

  setup_all do
    Gluttony.parse_string(@googleplay_rss2)
  end

  describe "googleplay rss 2.0 feed elements" do
    test "googleplay_author", %{feed: feed} do
      assert feed.googleplay_author == "Unannounced Podcaster"
    end

    test "googleplay_description", %{feed: feed} do
      assert feed.googleplay_description ==
               "The Unknown Podcast will look at all the things that are unknown or unknowable. Find us on Google Play Music!"
    end

    test "googleplay_email", %{feed: feed} do
      assert feed.googleplay_email == "unknown-podcast@sample.com"
    end

    test "googleplay_image", %{feed: feed} do
      assert feed.googleplay_image == "http://sample.com/podcasts/unknown/UnknownLargeImage.jpg"
    end

    test "googleplay_categories", %{feed: feed} do
      assert feed.googleplay_categories == ["Technology"]
    end
  end

  describe "googleplay rss 2.0 entry elements" do
    test "googleplay_author", %{entries: [entry | _]} do
      assert entry.googleplay_author == "Engima"
    end

    test "googleplay_description", %{entries: [entry | _]} do
      assert entry.googleplay_description == "We look at all the things that are out there that we'd like to know."
    end

    test "googleplay_image", %{entries: [entry | _]} do
      assert entry.googleplay_image == "http://sample.com/podcasts/unknown/Episode1.jpg"
    end
  end
end
