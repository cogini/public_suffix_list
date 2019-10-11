# PublicSuffixList

Parse DNS domain names using public suffix list from https://publicsuffix.org

The public suffix list disginguishes registerable domains from the "suffix" of
the domain. For simple TLDs like `.com`, it's clear which part is the name, but
there are many compoound suffixes like `.ac.uk`, and it becomes difficult to
tell what part is the name.

This list was originally defined by Mozilla to make sure that websites
could not set cookies on suffixes. It is also useful for normalizing
domains into registrable name, suffix and any subdomains.

This library reads the standard `public_suffix_list.dat` and generates
a `parse/1` function which matches domains against it, splitting them
into host/subdomains, name, and suffix:

```elixir
iex(1)> PublicSuffixList.parse("www.ic.ac.uk")
{:ok, {["www"], "ic", "ac.uk"}}
```

It also defines utility functions, `normalize/1` which removes the subdomains
and `name/1` which gets just the domain:

```elixir
iex(2)> PublicSuffixList.normalize("www.ic.ac.uk")
{:ok, "ic.ac.uk"}
iex(3)> PublicSuffixList.name("www.ic.ac.uk")
{:ok, "ic"}
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `public_suffix_list` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:public_suffix_list, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/public_suffix_list](https://hexdocs.pm/public_suffix_list).
