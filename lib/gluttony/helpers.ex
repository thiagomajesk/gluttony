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
end
