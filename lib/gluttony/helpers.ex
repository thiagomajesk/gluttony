defmodule Gluttony.Helpers do
  @moduledoc false

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
