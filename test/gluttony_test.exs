defmodule GluttonyTest do
  use ExUnit.Case
  doctest Gluttony

  @rss_2_0 File.read!("test/fixtures/rss_2_0")
  @atom_1_0 File.read!("test/fixtures/atom_1_0")

  test "detect rss 2.0" do
    assert Gluttony.detect(@rss_2_0) == :rss_2_0
  end

  test "detect atom 1.0" do
    assert Gluttony.detect(@atom_1_0) == :atom_1_0
  end
end
