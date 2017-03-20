defmodule ExLexicon.Mixfile do
  use Mix.Project

  def project do
    [app: :exlexicon,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps(),
     name: "ExLexicon",
     source_url: "https://github.com/rtvu/exlexicon",
     docs: [main: "readme", extras: ["README.md"]]]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:ex_doc, "~> 0.14", only: :dev, runtime: false}]
  end

  defp description do
    "A lexicon (word list) implemented in Elixir."
  end

  defp package do
    [licenses: ["MIT License"],
     links: %{"Github" => "https://github.com/rtvu/exlexicon"}]
  end
end
