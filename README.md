![test workflow](https://github.com/reachfh/logger_formatter_json/actions/workflows/test.yml/badge.svg)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](CODE_OF_CONDUCT.md)

# public_suffix_list

Parse DNS domain names using public suffix list from https://publicsuffix.org

The public suffix list distinguishes registrable domains from the "suffix" of
the domain. For simple TLDs like `.com`, it's clear which part is the name, but
there are many compound suffixes like `.ac.uk`, and it becomes difficult to
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

Add `public_suffix_list` to the list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:public_suffix_list, "~> 0.1.0"}
  ]
end
```

The docs can be found at [https://hexdocs.pm/public_suffix_list](https://hexdocs.pm/public_suffix_list).
