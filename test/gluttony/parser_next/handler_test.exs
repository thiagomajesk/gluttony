defmodule Gluttony.ParserNext.HandlerTest do
  use ExUnit.Case, async: true

  test "raises on duplicate rule sources" do
    assert_raise CompileError, ~r/rule source "channel\/title" as :content is already defined/, fn ->
      Code.compile_string("""
      defmodule Gluttony.ParserNext.DuplicateSourceRules do
        use Gluttony.ParserNext.Handler

        content "channel/title",
          target: [:feed, :title]

        content "channel/title",
          target: [:feed, :description]
      end
      """)
    end
  end

  test "raises on invalid rule types" do
    assert_raise CompileError, ~r/rule type must be one of .* got: :integer/, fn ->
      Code.compile_string("""
      defmodule Gluttony.ParserNext.InvalidTypeRules do
        use Gluttony.ParserNext.Handler

        content "channel/title",
          type: :integer,
          target: [:feed, :title]
      end
      """)
    end
  end

  test "raises on invalid rule sources" do
    assert_raise CompileError, ~r/rule source must be a valid source path, got: "channel\/\/title"/, fn ->
      Code.compile_string("""
      defmodule Gluttony.ParserNext.InvalidSourceRules do
        use Gluttony.ParserNext.Handler

        content "channel//title",
          target: [:feed, :title]
      end
      """)
    end
  end

  test "raises on invalid rule targets" do
    assert_raise CompileError, ~r/rule target must be a list, got: "feed.title"/, fn ->
      Code.compile_string("""
      defmodule Gluttony.ParserNext.InvalidTargetRules do
        use Gluttony.ParserNext.Handler

        content "channel/title",
          target: "feed.title"
      end
      """)
    end
  end
end
