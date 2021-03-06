defmodule Lexicon.Mixfile do
  use Mix.Project

  def project do
    [
      app: :lexicon,
      version: "0.2.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "Lexicon",
      source_url: "https://github.com/rtvu/lexicon",
      docs: [main: "readme", extras: ["README.md"]]
    ]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:ex_doc, "~> 0.19", only: :dev, runtime: false}]
  end

  defp description do
    "A lexicon (word list) implemented in Elixir."
  end

  defp package do
    [
      licenses: ["MIT License"],
      maintainers: [],
      links: %{"Github" => "https://github.com/rtvu/lexicon"}
    ]
  end
end
