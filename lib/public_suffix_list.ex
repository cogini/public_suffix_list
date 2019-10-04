defmodule PublicSuffixList do
  @moduledoc """
  Parse DNS domain names using public suffix list from https://publicsuffix.org
  """
  @app :public_suffix_list

  @input_file Path.join(:code.priv_dir(@app), "public_suffix_list.dat")
  @external_resource @input_file

  @spec match_suffix(list(binary)) :: {:ok, {list(binary), binary, binary}} | {:error, :unknown_suffix}

  @input_file
  |> File.read!
  |> String.split("\n")
  |> Enum.filter(&(not Regex.match?(~r/^\/\/|^\s*$/, &1)))
  |> Enum.map(&String.trim/1)
  |> Enum.reject(&(&1 == ""))
  |> Enum.map(&({&1 |> String.split(".") |> Enum.reverse, &1}))
  |> Enum.sort(&>=/2)
  |> Enum.map(fn {comps, suffix} ->
    args = comps ++ quote(do: [name | rest])
    result = quote(do: {:ok, {Enum.reverse(rest), name, unquote(suffix)}})
    def match_suffix(unquote(args)), do: unquote(result)
    end)

  def match_suffix(_) do
    {:error, :unknown_suffix}
  end

  @doc "Parse domain into subdomains, name and suffix"
  @spec parse(binary) :: {:ok, {list(binary), binary, binary}} | {:error, :unknown_suffix}
  def parse(domain) when is_binary(domain) do
    domain
    |> String.downcase()
    |> String.split(".")
    |> Enum.reverse()
    |> match_suffix()
  end

  @doc "Strip subdomain, leaving just name and suffix"
  @spec normalize(binary) :: binary | {:error, :unknown_suffix}
  def normalize(domain) when is_binary(domain) do
    case parse(domain) do
      {:ok, {_subdomains, name, suffix}} ->
        name <> "." <> suffix
      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc "Strip subdomain and suffix, leaving just the name"
  @spec name(binary) :: binary | {:error, :unknown_suffix}
  def name(domain) when is_binary(domain) do
    case parse(domain) do
      {:ok, {_subdomains, name, _suffix}} ->
        name
      {:error, reason} ->
        {:error, reason}
    end
  end
end
