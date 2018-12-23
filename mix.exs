defmodule NewsApi.Mixfile do
  use Mix.Project

  def project do
    [
      app: :news_api,
      version: "0.1.0",
      elixir: "~> 1.5",
      description: "API Wrapper for News API",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.5.0"},
      {:poison, "~> 4.0.1"},
      {:ex_doc, "~> 0.19.2", only: :dev, runtime: false},
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["radvc"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/radvc/news-api"}
    ]
  end
end
