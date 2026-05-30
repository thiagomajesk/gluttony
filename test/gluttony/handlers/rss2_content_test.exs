defmodule Gluttony.Handlers.RSS2ContentTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  @namespace_feed_url "https://newjerseymonitor.com/feed/"

  setup_all do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")

    use_cassette "new_jersey_monitor_feed" do
      Gluttony.fetch_feed(@namespace_feed_url)
    end
  end

  describe "content rss 2.0 entry elements" do
    test "content", %{entries: [entry | _]} do
      assert entry.content =~ ~s(<figure)
    end
  end
end
