defmodule PublicSuffixListTest do
  use ExUnit.Case
  doctest PublicSuffixList

  test "greets the world" do
    assert PublicSuffixList.hello() == :world
  end
end
