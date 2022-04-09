defmodule Gluttony.Accessor.EmptyValue do
  @moduledoc """
  Struct returned when a key does not exist in the feed or entry.
  """

  @type t :: %__MODULE__{__sources__: list(atom())}

  defstruct __sources__: []

  defimpl Inspect, for: __MODULE__ do
    def inspect(not_found, _opts) do
      msg = "no value found for keys #{inspect(not_found.__sources__)}"
      ~s(#Gluttony.Accessor.EmptyValue<#{msg}>)
    end
  end

  defimpl Phoenix.HTML.Safe, for: __MODULE__ do
    def to_iodata(_data), do: ""
  end
end

defmodule Gluttony.Accessor.Unparsed do
  @moduledoc """
  Struct returned when a value cannot be parsed.
  """

  @type t :: %__MODULE__{__value__: term()}

  defstruct [:__value__, :__expected__]

  defimpl Inspect, for: __MODULE__ do
    def inspect(unparsed, _opts) do
      msg = "unparsed value #{inspect(unparsed.__value__)}, expected #{inspect(unparsed.__expected__)}"
      ~s(#Gluttony.Accessor.Unparsed<#{msg}>)
    end
  end

  defimpl Phoenix.HTML.Safe, for: __MODULE__ do
    def to_iodata(%{__value__: value}), do: value
  end
end

defmodule Gluttony.Accessor do
  @moduledoc false

  alias Gluttony.Accessor.{EmptyValue, Unparsed}

  @doc """
  Accessor for feed and entry data.
  Returns the first value found or returns a `Gluttony.Access.EmptyValue` struct.
  """
  def get(container, keys) do
    Enum.reduce(keys, %EmptyValue{}, fn
      key, %{__sources__: sources} = not_found ->
        Access.get(container, key, %{not_found | __sources__: [key | sources]})

      _key, value ->
        value
    end)
  end

  @doc """
  Acts like `get/2`, but parsed the value accordinly to the expected type.
  """
  def get_parse(container, keys, expected, type) do
    case {expected, get(container, keys)} do
      {_, %EmptyValue{} = not_found} -> not_found
      {:datetime, value} -> parse_datetime(value, type)
      {:integer, value} -> parse_integer(value)
      {:cdata, value} -> parse_cdata(value)
      {_, value} -> value
    end
  end

  defp parse_datetime(str, :rss2) do
    parse_datetime(str, "{RFC1123}")
  end

  defp parse_datetime(str, :atom1) do
    parse_datetime(str, "{ISO:Extended}")
  end

  defp parse_datetime(str, format) do
    case Timex.parse(str, format) do
      {:ok, datetime} -> datetime
      {:error, _} -> %Unparsed{__value__: str, __expected__: :datetime}
    end
  end

  defp parse_integer(str) do
    case Integer.parse(str) do
      {integer, _} -> integer
      :error -> %Unparsed{__value__: str, __expected__: :integer}
    end
  end

  defp parse_cdata(term) when is_binary(term) do
    term
    |> Phoenix.HTML.html_escape()
    |> Phoenix.HTML.Safe.to_iodata()
  end
end
