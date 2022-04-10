defmodule Gluttony.Fetchers.Opengraph do
  @moduledoc """
  Retrieves opengraph information available in the given URL.
  Exposes the same functions as `HTTPoison`.
  """

  use HTTPoison.Base

  @tags ~w(
    og:title og:type og:image og:url
    og:audio og:description og:determiner
    og:locale og:locale og:site_name
    og:video

    og:image og:image:url og:image:secure_url
    og:image:type og:image:width og:image:height
    og:image:alt

    og:video og:video:url og:video:secure_url
    og:video:type og:video:width og:video:height
    og:video:alt

    music:duration music:album music:album:disc
    music:album:track music:musician music:song
    music:song:disc music:song:track music:release_date
    music:creator

    video:actor video:actor:role video:director
    video:duration video:release_date video:tag
    video:writer video:series

    article:published_time article:modified_time article:expiration_time
    article:author article:section article:tag

    book:author book:isbn book:release_date
    book:tag

    profile:first_name profile:last_name profile:username
    profile:gender
  )

  def process_response_body(body) do
    with {:ok, document} <- Floki.parse_document(body) do
      document
      |> Floki.find(selectors())
      |> Map.new(&extract_content/1)
    end
  end

  defp extract_content(element) do
    [property] = Floki.attribute(element, "property")
    [content] = Floki.attribute(element, "content")
    {property, content}
  end

  defp selectors() do
    @tags
    |> Enum.map(&"meta[property=\"#{&1}\"]")
    |> Enum.join(",")
  end
end
