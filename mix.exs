defmodule PublicSuffixList.MixProject do
  use Mix.Project

  def project do
    [
      app: :public_suffix_list,
      version: "0.1.0",
      elixir: "~> 1.8",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      source_url: "https://github.com/cogini/public_suffix_list",
      homepage_url: "https://github.com/cogini/public_suffix_list",
      deps: deps(),
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.19.2", only: :dev, runtime: false},
      # {:dialyxir, "~> 0.5.1", only: [:dev, :test], runtime: false},
    ]
  end
  defp description do
    "Parses DNS domains using public suffix list."
  end

  defp package do
    [
      maintainers: ["Jake Morrison"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/cogini/public_suffix_list"}
    ]
  end

  defp docs do
    [
      source_url: "https://github.com/cogini/public_suffix_list",
      extras: ["README.md"]
    ]
  end
end
