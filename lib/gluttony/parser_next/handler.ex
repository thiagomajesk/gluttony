defmodule Gluttony.ParserNext.Handler do
  @moduledoc false

  @rule_source ~r/^[A-Za-z_][A-Za-z0-9_:-]*(\/[A-Za-z_][A-Za-z0-9_:-]*)*$/
  @rule_types [:string, {:array, :string}]

  @type attr :: {binary(), term()}
  @type result :: {:ok, state()} | {:cont, state()}
  @type stack :: list(binary())
  @type state :: map()

  @callback handle_attribute(stack(), attr(), state()) :: result()
  @callback handle_element(stack(), state()) :: result()
  @callback handle_content(stack(), state()) :: result()

  defmacro __using__(_opts) do
    quote do
      @behaviour Gluttony.ParserNext.Handler
      @before_compile Gluttony.ParserNext.Handler.Compiler

      import Gluttony.ParserNext.Handler, only: [attribute: 2, content: 2, element: 2]

      Module.register_attribute(__MODULE__, :rules, accumulate: true)
    end
  end

  defmacro attribute(source, opts) do
    rule =
      opts
      |> Keyword.put_new(:type, :string)
      |> Keyword.put(:source, source)
      |> Enum.into(%{})

    define_rule(:attribute, rule)
  end

  defmacro content(source, opts) do
    rule =
      opts
      |> Keyword.put_new(:type, :string)
      |> Keyword.put(:source, source)
      |> Enum.into(%{})

    define_rule(:content, rule)
  end

  defmacro element(source, opts) do
    rule =
      opts
      |> Keyword.put_new(:value, %{})
      |> Keyword.put(:source, source)
      |> Enum.into(%{})

    define_rule(:element, rule)
  end

  @doc false
  def validate_rule!(kind, rule, rules, caller) do
    validate_rule_type!(rule, caller)
    validate_rule_source!(rule, caller)
    validate_rule_target!(rule, caller)
    validate_rule_source_unique!(kind, rule, rules, caller)
  end

  defp validate_rule_type!(rule, caller) do
    if Map.has_key?(rule, :type) and rule.type not in @rule_types do
      raise CompileError,
        file: caller.file,
        line: caller.line,
        description: "rule type must be one of #{inspect(@rule_types)}, got: #{inspect(rule.type)}"
    end
  end

  defp validate_rule_source!(rule, caller) do
    if not is_binary(rule.source) or not Regex.match?(@rule_source, rule.source) do
      raise CompileError,
        file: caller.file,
        line: caller.line,
        description: "rule source must be a valid source path, got: #{inspect(rule.source)}"
    end
  end

  defp validate_rule_target!(rule, caller) do
    if not is_list(rule.target) do
      raise CompileError,
        file: caller.file,
        line: caller.line,
        description: "rule target must be a list, got: #{inspect(rule.target)}"
    end
  end

  defp validate_rule_source_unique!(kind, rule, rules, caller) do
    if Enum.any?(rules, fn {stored_kind, stored_rule} -> stored_kind == kind and stored_rule.source == rule.source end) do
      raise CompileError,
        file: caller.file,
        line: caller.line,
        description: "rule source #{inspect(rule.source)} as #{inspect(kind)} is already defined"
    end
  end

  defp define_rule(kind, rule) do
    quote do
      kind = unquote(kind)
      rule = unquote(Macro.escape(rule))
      rules = Module.get_attribute(__MODULE__, :rules, [])

      unquote(__MODULE__).validate_rule!(kind, rule, rules, __ENV__)

      Module.put_attribute(__MODULE__, :rules, {kind, rule})
    end
  end
end
