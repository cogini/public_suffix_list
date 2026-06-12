defmodule PublicSuffixListTest do
  use ExUnit.Case, async: true

  test "parse/1" do
    assert PublicSuffixList.parse("www.ic.ac.uk") == {:ok, {["www"], "ic", "ac.uk"}}
    assert PublicSuffixList.parse("www.foo.uk") == {:ok, {["www"], "foo", "uk"}}
    assert PublicSuffixList.parse("www.example.com") == {:ok, {["www"], "example", "com"}}
    assert PublicSuffixList.parse("example.com") == {:ok, {[], "example", "com"}}

    assert PublicSuffixList.parse("www.subdomain.example.com") ==
             {:ok, {["www", "subdomain"], "example", "com"}}

    assert PublicSuffixList.parse("invalid") == {:error, :unknown_suffix}
    assert PublicSuffixList.parse("") == {:error, :unknown_suffix}
    assert PublicSuffixList.parse("8.8.8.8") == {:error, :unknown_suffix}
  end

  test "normalize/1" do
    assert PublicSuffixList.normalize("www.ic.ac.uk") == {:ok, "ic.ac.uk"}
    assert PublicSuffixList.normalize("www.example.com") == {:ok, "example.com"}
    assert PublicSuffixList.normalize("invalid") == {:error, :unknown_suffix}
    assert PublicSuffixList.normalize("") == {:error, :unknown_suffix}
    assert PublicSuffixList.normalize("8.8.8.8") == {:error, :unknown_suffix}
  end

  test "name/1" do
    assert PublicSuffixList.name("www.ic.ac.uk") == {:ok, "ic"}
    assert PublicSuffixList.name("www.example.com") == {:ok, "example"}
    assert PublicSuffixList.name("invalid") == {:error, :unknown_suffix}
    assert PublicSuffixList.name("") == {:error, :unknown_suffix}
    assert PublicSuffixList.name("8.8.8.8") == {:error, :unknown_suffix}
  end

  describe "is_suffix/1" do
    test "domain with subdomain is false" do
      refute PublicSuffixList.is_suffix("www.example.com")
    end

    test "domain without subdomain is false" do
      refute PublicSuffixList.is_suffix("example.com")
    end

    test "bare suffix is true" do
      assert PublicSuffixList.is_suffix("com")
    end

    test "multi-part domain with subdomain is false" do
      refute PublicSuffixList.is_suffix("www.ic.ac.uk")
    end

    test "multi-part domain without subdomain is false" do
      refute PublicSuffixList.is_suffix("ic.ac.uk")
    end

    test "multi-part bare suffix is true" do
      assert PublicSuffixList.is_suffix("ac.uk")
    end

    test "commponent of multi-part bare suffix is true" do
      assert PublicSuffixList.is_suffix("uk")
    end

    test "empty string is false" do
      refute PublicSuffixList.is_suffix("")
    end

    test "invalid name is false" do
      refute PublicSuffixList.is_suffix("wpad")
    end

    test "IP address is false" do
      refute PublicSuffixList.is_suffix("8.8.8.8")
    end
  end
end
