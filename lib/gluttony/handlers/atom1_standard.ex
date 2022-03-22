defmodule Gluttony.Handlers.Atom1Standard do
  @behaviour Gluttony.Handler

  @impl true
  def handle_element(attrs, stack) do
    case stack do
      ["entry"] ->
        {:entry, attrs}

      ["link"] ->
        attrs = Map.new(attrs)
        link = attrs["href"]
        {:feed, :links, [link]}

      ["category"] ->
        attrs = Map.new(attrs)
        category = attrs["term"]
        {:feed, :categories, [category]}

      ["category", "entry"] ->
        attrs = Map.new(attrs)
        category = attrs["term"]
        {:entry, :categories, [category]}

      ["link", "entry"] ->
        attrs = Map.new(attrs)
        link = attrs["href"]
        {:entry, :links, [link]}

      _ ->
        {:cont, attrs}
    end
  end

  @impl true
  def handle_content(chars, stack) do
    case stack do
      ["title"] ->
        {:feed, :title, chars}

      ["subtitle"] ->
        {:feed, :subtitle, chars}

      ["logo"] ->
        {:feed, :logo, chars}

      ["icon"] ->
        {:feed, :icon, chars}

      ["updated"] ->
        {:feed, :updated, chars}

      ["id"] ->
        {:feed, :id, chars}

      ["rights"] ->
        {:feed, :rights, chars}

      ["generator"] ->
        {:feed, :generator, chars}

      ["name", "contributor"] ->
        {:feed, :contributors, [chars]}

      ["name", "author"] ->
        {:feed, :authors, [chars]}

      ["title", "entry"] ->
        {:entry, :title, chars}

      ["id", "entry"] ->
        {:entry, :id, chars}

      ["updated", "entry"] ->
        {:entry, :updated, chars}

      ["published", "entry"] ->
        {:entry, :published, chars}

      ["summary", "entry"] ->
        {:entry, :summary, chars}

      ["content", "entry"] ->
        {:entry, :content, chars}

      ["name", "author", "entry"] ->
        {:entry, :authors, [chars]}

      ["name", "contributor", "entry"] ->
        {:entry, :contributors, [chars]}

      ["id", "source", "entry"] ->
        {:entry, [:source, :id], chars}

      ["title", "source", "entry"] ->
        {:entry, [:source, :title], chars}

      ["updated", "source", "entry"] ->
        {:entry, [:source, :updated], chars}

      ["rights", "source", "entry"] ->
        {:entry, [:source, :rights], chars}

      ["rights", "entry"] ->
        {:entry, :rights, chars}

      _ ->
        {:cont, chars}
    end
  end

  @impl true
  def to_feed(_feed, _entries) do
    raise "Not implemented"
  end
end