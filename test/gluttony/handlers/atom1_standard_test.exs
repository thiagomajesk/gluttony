defmodule Gluttony.Handlers.Atom1StandardTest do
  use ExUnit.Case

  @standard_atom1 File.read!("test/fixtures/atom1_standard.rss")

  setup_all do
    Gluttony.parse_string(@standard_atom1)
  end

  describe "atom 1.0 feed elements" do
    test "id", %{feed: feed} do
      assert feed.id == "http://example.com/"
    end

    test "title", %{feed: feed} do
      assert feed.title == "Example, Inc."
    end

    test "subtitle", %{feed: feed} do
      assert feed.subtitle == "all your examples are belong to us"
    end

    test "updated", %{feed: feed} do
      assert feed.updated == "2003-12-13T18:30:02Z"
    end

    test "icon", %{feed: feed} do
      assert feed.icon == "/icon.jpg"
    end

    test "logo", %{feed: feed} do
      assert feed.logo == "/logo.jpg"
    end

    test "rights", %{feed: feed} do
      assert feed.rights == " © 2005 John Doe "
    end

    test "authors", %{feed: feed} do
      assert feed.authors == ["Mary Doe", "John Doe"]
    end

    test "links", %{feed: feed} do
      assert feed.links == ["http://example.com/feed.atom", "http://example.com/"]
    end

    test "categories", %{feed: feed} do
      assert feed.categories == ["general", "sports"]
    end

    test "contributors", %{feed: feed} do
      assert feed.contributors == ["Mark Doe", "Jane Doe"]
    end

    test "generator", %{feed: feed} do
      assert feed.generator == "Example Toolkit"
    end
  end

  describe "atom 1.0 entry elements" do
    test "id", %{entries: [entry | _]} do
      assert entry.id == "http://example.com/blog/1234"
    end

    test "title", %{entries: [entry | _]} do
      assert entry.title == "Atom-Powered Robots Run Amok"
    end

    test "updated", %{entries: [entry | _]} do
      assert entry.updated == "2003-12-13T18:30:02-05:00"
    end

    test "published", %{entries: [entry | _]} do
      assert entry.published == "2003-12-13T08:29:29-04:00"
    end

    test "authors", %{entries: [entry | _]} do
      assert entry.authors == ["Mary Doe", "John Doe"]
    end

    test "summary", %{entries: [entry | _]} do
      assert entry.summary == "Some text."
    end

    test "content", %{entries: [entry | _]} do
      assert entry.content == "complete story here"
    end

    test "links", %{entries: [entry | _]} do
      assert entry.links == [
               "http://example.org/audio/ph34r_my_podcast.mp3",
               "http://example.org/2005/04/02/atom"
             ]
    end

    test "categories", %{entries: [entry | _]} do
      assert entry.categories == ["general", "sports"]
    end

    test "contributors", %{entries: [entry | _]} do
      assert entry.contributors == ["Joe Gregorio", "Sam Ruby"]
    end

    test "source", %{entries: [entry | _]} do
      assert %{
               id: "http://example.org/",
               title: "Fourty-Two",
               updated: "2003-12-13T18:30:02Z",
               rights: "© 2005 Example, Inc."
             } = entry.source
    end

    test "rights", %{entries: [entry | _]} do
      assert entry.rights == "&copy; 2005 John Doe"
    end
  end
end
