defmodule Gluttony.ParserNext.Handler.Compiler do
  @moduledoc false

  defmacro __before_compile__(env) do
    rules = ordered_rules(env.module)

    quote do
      import Gluttony.ParserNext.Handler.Compiler

      @impl true
      def handle_attribute(stack, attr, state)

      unquote_splicing(generate_attribute_clauses(rules))

      def handle_attribute(_stack, _attr, state), do: {:cont, state}

      @impl true
      def handle_element(stack, state)

      unquote_splicing(generate_element_clauses(rules))

      def handle_element(_stack, state), do: {:cont, state}

      @impl true
      def handle_content(stack, state)

      unquote_splicing(generate_content_clauses(rules))

      def handle_content(_stack, state), do: {:cont, state}
    end
  end

  @doc false
  def access_path([key]), do: [key]
  def access_path([key | path]) when is_atom(key), do: [Access.key(key, %{}) | access_path(path)]
  def access_path([key | path]), do: [key | access_path(path)]

  @doc false
  def place_in(state, path, value) do
    update_in(state, [:result | access_path(path)], fn
      current when is_list(current) ->
        [value | current]

      current when is_map(current) and is_map(value) ->
        Map.merge(current, value)

      _current ->
        value
    end)
  end

  @doc false
  def text(nil), do: nil
  def text(content) when is_binary(content), do: content
  def text(content), do: IO.iodata_to_binary(content)

  defp generate_attribute_clauses(rules) do
    for {:attribute, rule} <- rules do
      [attribute | path] = matching_path(rule.source)

      quote do
        def handle_attribute(unquote(path), {unquote(attribute), value}, state) do
          {:ok, place_in(state, unquote(rule.target), value)}
        end
      end
    end
  end

  defp generate_element_clauses(rules) do
    for {:element, rule} <- rules do
      path = matching_path(rule.source)

      quote do
        def handle_element(unquote(path), state) do
          {:ok, place_in(state, unquote(rule.target), unquote(Macro.escape(rule.value)))}
        end
      end
    end
  end

  defp generate_content_clauses(rules) do
    for {:content, rule} <- rules do
      path = matching_path(rule.source)

      quote do
        def handle_content(unquote(path), state) do
          {:ok, place_in(state, unquote(rule.target), text(state.content))}
        end
      end
    end
  end

  defp ordered_rules(module) do
    module
    |> Module.get_attribute(:rules)
    |> Enum.sort_by(&rule_depth/1, :desc)
  end

  defp rule_depth({_kind, rule}) do
    length(matching_path(rule.source))
  end

  defp matching_path(source) do
    source
    |> String.split("/", trim: true)
    |> Enum.reverse()
  end
end
