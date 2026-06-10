defmodule RawParser do
  @moduledoc """
  Minimal RSS2 SAX parser demo.
  """

  @behaviour Saxy.Handler

  def parse(xml) when is_binary(xml) do
    Saxy.parse_string(xml, __MODULE__, nil)
  end

  def handle_event(:start_document, _prolog, _state) do
    {:ok, {[], %{}}}
  end

  def handle_event(:start_element, {name, _attrs}, {stack, result}) do
    {:ok, {[{name, nil, []} | stack], result}}
  end

  def handle_event(:characters, chars, {[frame | rest], result}) do
    case String.trim(chars) do
      "" ->
        {:ok, {[frame | rest], result}}

      chars ->
        {name, text, children} = frame

        {:ok, {[{name, append_text(text, chars), children} | rest], result}}
    end
  end

  def handle_event(:end_element, _name, {[frame], result}) do
    {:ok, {[], put_result(result, frame)}}
  end

  def handle_event(:end_element, _name, {[frame, parent | rest], result}) do
    {:ok, {[put_child(parent, frame) | rest], result}}
  end

  def handle_event(:end_document, _data, {_stack, result}) do
    {:ok, result}
  end

  defp put_result(result, frame) do
    {name, _text, _children} = frame
    Map.put(result, name, to_node(frame))
  end

  defp put_child(parent, frame) do
    {name, _text, _children} = frame
    {parent_name, parent_text, parent_children} = parent

    case to_node(frame) do
      nil ->
        {parent_name, parent_text, parent_children}

      node ->
        {parent_name, parent_text, [{name, node} | parent_children]}
    end
  end

  defp to_node({_name, nil, []}), do: nil
  defp to_node({_name, text, []}), do: text(text)
  defp to_node({_name, text, [{name, node}]}), do: put_text(%{name => node}, text)

  defp to_node({_name, text, children}) do
    children
    |> group_children()
    |> put_text(text)
  end

  defp group_children(children) do
    Enum.reduce(children, %{}, fn {name, node}, children ->
      case Map.get(children, name) do
        nil -> Map.put(children, name, node)
        nodes when is_list(nodes) -> Map.put(children, name, [node | nodes])
        child -> Map.put(children, name, [node, child])
      end
    end)
  end

  defp put_text(node, text) do
    case text(text) do
      "" -> node
      text -> Map.put(node, "#text", text)
    end
  end

  defp append_text(nil, chars), do: chars
  defp append_text(text, chars), do: [text | chars]

  defp text(nil), do: ""
  defp text(chars) when is_binary(chars), do: chars
  defp text(chunks), do: IO.iodata_to_binary(chunks)
end
