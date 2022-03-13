defmodule GluttonyTest do
  use ExUnit.Case
  doctest Gluttony

  @rss2 File.read!("test/fixtures/basic_rss2")
  @atom1 File.read!("test/fixtures/basic_atom1")

  test "detect rss 2.0" do
    assert Gluttony.detect(@rss2) == :rss2
  end

  test "detect atom 1.0" do
    assert Gluttony.detect(@atom1) == :atom1
  end
end
