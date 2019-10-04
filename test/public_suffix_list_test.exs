defmodule PublicSuffixListTest do
  use ExUnit.Case, async: true

  test "parse" do
    assert PublicSuffixList.parse("www.ic.ac.uk") == {:ok, {["www"], "ic", "ac.uk"}}
    assert PublicSuffixList.parse("www.foo.uk") == {:ok, {["www"], "foo", "uk"}}
    assert PublicSuffixList.parse("www.example.com") == {:ok, {["www"], "example", "com"}}
    assert PublicSuffixList.parse("example.com") == {:ok, {[], "example", "com"}}
    assert PublicSuffixList.parse("www.subdomain.example.com") == {:ok, {["www", "subdomain"], "example", "com"}}
    assert PublicSuffixList.parse("invalid") == {:error, :unknown_suffix}
    assert PublicSuffixList.parse("") == {:error, :unknown_suffix}
    assert PublicSuffixList.parse("8.8.8.8") == {:error, :unknown_suffix}
  end

  test "normalize" do
    assert PublicSuffixList.normalize("www.ic.ac.uk") == "ic.ac.uk"
    assert PublicSuffixList.normalize("www.example.com") == "example.com"
    assert PublicSuffixList.normalize("invalid") == {:error, :unknown_suffix}
    assert PublicSuffixList.normalize("") == {:error, :unknown_suffix}
    assert PublicSuffixList.parse("8.8.8.8") == {:error, :unknown_suffix}
  end

  test "name" do
    assert PublicSuffixList.name("www.ic.ac.uk") == "ic"
    assert PublicSuffixList.name("www.example.com") == "example"
    assert PublicSuffixList.name("invalid") == {:error, :unknown_suffix}
    assert PublicSuffixList.name("") == {:error, :unknown_suffix}
    assert PublicSuffixList.parse("8.8.8.8") == {:error, :unknown_suffix}
  end
end
