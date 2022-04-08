defmodule Gluttony.Fetchers.Favicon do
  use HTTPoison.Base

  def process_response_body(body) do
    with {:ok, document} <- Floki.parse_document(body) do
      document
      |> Floki.find("link[rel*=icon]")
      |> Enum.map(&extract_content/1)
    end
  end

  defp extract_content(element) do
    rel = Floki.attribute(element, "rel")
    size = Floki.attribute(element, "sizes")
    href = Floki.attribute(element, "href")
    type = Floki.attribute(element, "type")
    color = Floki.attribute(element, "color")

    %{
      __rel__: from_list(rel),
      size: from_list(size),
      href: from_list(href),
      type: from_list(type),
      color: from_list(color)
    }
  end

  defp from_list([]), do: nil
  defp from_list([t]), do: t
  defp from_list(list), do: list
end
