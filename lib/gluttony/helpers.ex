defmodule Gluttony.Helpers do
  @doc """
  Transforms a term into a underscore atom key.
  """
  def key_to_atom(term) do
    term
    |> to_string()
    |> Macro.underscore()
    |> String.to_existing_atom()
  end

  @doc """
  Parses datetime or returns the original value.
  """
  def parse_datetime(str) do
    case Timex.parse(str, "{RFC1123}") do
      {:ok, datetime} -> datetime
      {:error, value} -> value
    end
  end

  @doc """
  Parses integer or returns the original value.
  """
  def parse_integer(str) do
    case Integer.parse(str) do
      {integer, _} -> integer
      :error -> str
    end
  end

  @doc """
  Parses the given binary term as iodata.
  """
  def parse_cdata(term) when is_binary(term) do
    term
    |> Phoenix.HTML.html_escape()
    |> Phoenix.HTML.Safe.to_iodata()
  end

  @doc """
  Puts the value in the given path, creating intermidiate values
  if necessary. If the value is a list, it'll append the new value to existing ones.
  """
  def place_in(data, path, value)

  def place_in(data, path, [v] = value) when is_list(value) do
    update_in(data, Enum.map(path, &Access.key(&1, [])), &[v | &1])
  end

  def place_in(data, path, value) do
    put_in(data, Enum.map(path, &Access.key(&1, %{})), value)
  end
end
