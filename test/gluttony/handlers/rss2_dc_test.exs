defmodule Gluttony.Handlers.RSS2DCTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  @namespace_feed_url "https://newjerseymonitor.com/feed/"

  setup_all do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")

    use_cassette "new_jersey_monitor_feed" do
      Gluttony.fetch_feed(@namespace_feed_url)
    end
  end

  describe "dc rss 2.0 entry elements" do
    test "author", %{entries: entries} do
      assert Enum.any?(entries, & &1.author)
    end
  end
end
