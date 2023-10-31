defmodule PublicSuffixList.MixProject do
  use Mix.Project

  def project do
    [
      app: :public_suffix_list,
      version: "0.2.0",
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
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.2", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.29", only: :dev, runtime: false},
      {:excoveralls, "~> 0.14", only: [:dev, :test], runtime: false},
      {:junit_formatter, "~> 3.3", only: [:dev, :test], runtime: false},
      {:mix_audit, "~> 2.0", only: [:dev, :test], runtime: false},
      {:styler, "~> 0.9.6", only: [:dev, :test], runtime: false}
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
