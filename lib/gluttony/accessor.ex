defmodule Gluttony.Accessor.EmptyValue do
  @moduledoc """
  Struct returned by when a key does not exist in the feed or entry.
  """

  @type t :: %__MODULE__{__sources__: list(atom())}

  defstruct __sources__: []

  defimpl Inspect do
    def inspect(not_found, _opts) do
      msg = "no value found for keys #{inspect(not_found.__sources__)}"
      ~s(#Gluttony.Accessor.EmptyValue<#{msg}>)
    end
  end
end

defmodule Gluttony.Accessor do
  @moduledoc false

  @doc """
  Accessor for feed and entry data.
  Returns the first value found or returns a `Gluttony.Access.EmptyValue` struct.
  """
  def get(container, keys) do
    Enum.reduce(keys, %Gluttony.Accessor.EmptyValue{}, fn
      key, %{__sources__: sources} = not_found ->
        Access.get(container, key, %{not_found | __sources__: [key | sources]})

      _key, value ->
        value
    end)
  end
end
